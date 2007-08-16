Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7GIX7AW016487
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 14:33:07 -0400
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7GIX1qE026836
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 18:33:02 GMT
Received: from localhost.localdomain (tresys-winxppro [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l7GIWvLw003239
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 14:32:57 -0400
Received: (from mgoldman@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l7GIWvf6003238
	for selinux@tycho.nsa.gov; Thu, 16 Aug 2007 14:32:57 -0400
Message-Id: <20070816183257.447285544@tresys.com>>
References: <20070816182854.469714631@tresys.com>>
Date: Thu, 16 Aug 2007 14:28:55 -0400
From: Mark Goldman <mgoldman@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [POLICYREP] [Patch 1/2] Generalize an output function to make display easier.
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Generalize an output function to make display easier.

---
 libpolicyrep/include/policyrep/policy_base.hpp |   39 	36 +	3 -	0 !
 libpolicyrep/src/policy_base.cpp               |   22 	4 +	18 -	0 !
 2 files changed, 40 insertions(+), 21 deletions(-)

--- cpp-policyrep.orig/libpolicyrep/src/policy_base.cpp
+++ cpp-policyrep/libpolicyrep/src/policy_base.cpp
@@ -37,30 +37,16 @@ namespace policyrep
 	{
 		if (set.size() > 1)
 			o << "{ ";
-		StringSet::const_iterator i;
-		bool first = true;
-		for (i = set.begin(); i != set.end(); ++i) {
-			if (first)
-				first = false;
-			else
-				o << " ";
-			o << *i;
-		}
+
+		output_container(o, set.begin(), set.end(), " ");
+
 		if (set.size() > 1)
 			o << " }";
 	}
 
 	void output_set_comma(std::ostream& o, const StringSet& set)
 	{
-		StringSet::const_iterator i;
-		bool first = true;
-		for (i = set.begin(); i != set.end(); ++i) {
-			if (first)
-				first = false;
-			else
-				o << ", ";
-			o << *i;
-		}
+		output_container(o, set.begin(), set.end(), ", ");
 	}
 
 	std::ostream& operator<<(std::ostream& o, const Node& n)
--- cpp-policyrep.orig/libpolicyrep/include/policyrep/policy_base.hpp
+++ cpp-policyrep/libpolicyrep/include/policyrep/policy_base.hpp
@@ -8,11 +8,13 @@
 #include <string>
 #include <functional>
 #include <ostream>
+#include <iterator>
 
 #include <boost/shared_ptr.hpp>
 #include <boost/iterator/iterator_facade.hpp>
 
 namespace policyrep {
+	using std::string;
 
 	// Forward declarations
         class Node;
@@ -34,6 +36,37 @@ namespace policyrep {
         typedef boost::shared_ptr<StringVector> StringVectorPtr;
 
 	// Output (string output)
+	template<class iter>
+	void output_container(std::ostream& o, const iter& beg, const iter& end, 
+			const string sep)
+	{
+		bool first = true;
+		for(iter i = beg; i != end; i++) 
+		{
+			if(!first){
+				o << sep;
+			}
+			o << *i;
+			first = false;
+		}
+	}
+
+	template<class iter>
+	void bracket_output_container(std::ostream& o, const iter& beg, 
+			const iter& end, const string sep, 
+			const string pre, const string post)
+	{
+		iter temp = beg;
+		++temp;
+		if(temp != end){
+			o << pre;
+		}
+		output_container(o, beg, end, sep);
+		if(temp != end){
+			o << post;
+		}
+	}
+
         std::ostream& operator<<(std::ostream& o, const Node& n);
 
         void output_set_space(std::ostream& o, const StringSet& set);
@@ -149,10 +182,10 @@ namespace policyrep {
 		virtual void make_child(NodePtr node);
 
 		template<class T>
-		void append_children(T begin, T end)
+		void append_children(T start, T finish)
 		{
-			for (; begin != end; ++begin)
-				append_child(*begin);
+			for (; start != finish; ++start)
+				append_child(*start);
 		}
 
                 virtual NodeVector& children();

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
