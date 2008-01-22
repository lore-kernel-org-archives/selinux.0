Message-Id: <20080121160229.174189374@manicmethod.com>
References: <20080121160031.792610312@manicmethod.com>
Date: Tue, 22 Jan 2008 14:43:37 -0500
From: Joshua Brindle <method@manicmethod.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com, tmiller@tresys.com
Subject: [POLICYREP] [patch 6/7] add negset to idset
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add negset to idset for use in av rules

---
 libpolicyrep/include/policyrep/idset.hpp |   15 +++++++++++++++
 libpolicyrep/src/idset.cpp               |    6 ++++++
 2 files changed, 21 insertions(+)

--- policyrep.new.orig/libpolicyrep/include/policyrep/idset.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/idset.hpp
@@ -6,6 +6,7 @@
 #include <policyrep/policy_base.hpp>
 
 #include <set>
+#include <algorithm>
 
 namespace policyrep
 {
@@ -15,6 +16,19 @@ namespace policyrep
 	public:
 		IdSet();
 		IdSet(const IdSet& other);
+		template<typename I>
+		IdSet(bool comp, I sids, I eids){
+			init();
+			set_compl(comp);
+			ids().insert(sids, eids);
+		}
+		template<typename I>
+		IdSet(bool comp, I sids, I eids, I snids, I enids){
+			init();
+			set_compl(comp);
+			ids().insert(sids, eids);
+			neg_ids().insert(snids, enids);
+		}
 		~IdSet();
 		IdSet& operator=(const IdSet& other);
 
@@ -22,6 +36,7 @@ namespace policyrep
 		bool get_compl() const;
 
 		StringSet& ids();
+		StringSet& neg_ids();
 	protected:
 		void init();
 		IdSetImpl* impl;
--- policyrep.new.orig/libpolicyrep/src/idset.cpp
+++ policyrep.new/libpolicyrep/src/idset.cpp
@@ -27,6 +27,7 @@ namespace policyrep
 	{
 		IdSetImpl() : compliment(false) { }
 		StringSet ids;
+		StringSet neg_ids;
 		bool compliment;
 	};
 
@@ -66,4 +67,9 @@ namespace policyrep
 		return impl->ids;
 	}
 
+	StringSet& IdSet::neg_ids()
+	{
+		return impl->neg_ids;
+	}
+
 } // namespace policyre

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
