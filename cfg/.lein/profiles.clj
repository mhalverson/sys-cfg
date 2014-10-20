{:user {:plugins [[lein-difftest "1.3.8"]
                  [lein-marginalia "0.7.1"]
                  [lein-pprint "1.1.1"]
                  [lein-localrepo "0.5.2"]
                  [lein-clojars "0.9.0"]
                  [lein-kibit "0.0.8"]
                  [cider/cider-nrepl "0.8.0-SNAPSHOT"]
                  [org.clojure/tools.namespace "0.2.7"]]
        :dependencies [[slamhound "1.5.5"]
                       [clj-stacktrace "0.2.8"]
                       [aprint "0.1.0"]
                       [com.onekingslane.danger/clojure-common-utils "0.0.24"]]
        :repl-options {;; This expression will run when first opening a REPL, in the
                       ;; namespace from :init-ns or :main if specified.
                       :init (do
                               (require '[clojure.pprint :refer [pprint pp]])
                               (require '[roxxi.utils.print :refer [print-expr]])
                               (require '[clojure.reflect :as r])
                               (defn list-methods [obj]
                                 (clojure.pprint/print-table
                                  (sort-by :name
                                           (filter :exception-types (:members (r/reflect obj))))))
                               (defn list-fields [obj]
                                 (clojure.pprint/print-table
                                  (sort-by :name
                                           (filter #(= (class %) clojure.reflect.Field) (:members (r/reflect obj))))))
                               (require '[aprint.core :refer [aprint]])
                               (require '[clojure.tools.namespace.repl :refer [refresh]]))
                       ;; Print stack traces on exceptions (highly recommended, but
                       ;; currently overwrites *1, *2, etc).
                       ;; :caught clj-stacktrace.repl/pst+
                       }}}
