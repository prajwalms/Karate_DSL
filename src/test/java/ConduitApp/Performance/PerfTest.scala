
import ConduitApp.Performance.CreateTokens.CreateToken
import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._

import scala.concurrent.duration._

class PerfTest extends Simulation {


  CreateToken.createAccessTokens();

  val protocol = karateProtocol(
    "/api/articles/{slug}" -> Nil
  )

  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val tokenFeeder = Iterator.continually {
    Map("token" -> CreateToken.getNextToken)
  }
  val readTestData = csv("src/test/java/ConduitApp/Performance/Data/Articles.csv").circular
  val createArticle = scenario("create and Delete Articles").feed(readTestData).feed(tokenFeeder)
    .exec(karateFeature("classpath:ConduitApp/Performance/CreateArticles.feature"))

  setUp(
    createArticle.inject(
      atOnceUsers(1),
      constantUsersPerSec(1).during(3.seconds)
    )
      .protocols(protocol),
  )

}