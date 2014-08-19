import Language.Copilot
import Copilot.Compile.C99

spec :: Spec
spec = do
	trigger "example_trigger" test []

	where
		test :: Stream Bool
		test = externFun "check_pin_pair" [] Nothing


main = reify spec >>= compile defaultParams{verbose = False}
