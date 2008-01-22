Message-Id: <20080121160226.737131703@manicmethod.com>
References: <20080121160031.792610312@manicmethod.com>
Date: Tue, 22 Jan 2008 14:43:34 -0500
From: Joshua Brindle <method@manicmethod.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com, tmiller@tresys.com
Subject: [POLICYREP] [patch 3/7] remove duplicated optional.hpp data
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Somehow optional.hpp ended up duplicated twice, remove the extra junk

---
 libpolicyrep/include/policyrep/optional.hpp |   46 ----------------------------
 1 file changed, 46 deletions(-)

--- policyrep.new.orig/libpolicyrep/include/policyrep/optional.hpp
+++ policyrep.new/libpolicyrep/include/policyrep/optional.hpp
@@ -44,49 +44,3 @@ namespace policyrep
 } // namespace policyrep
 
 #endif
-/* Author: Karl MacMillan <kmacmillan@mentalrootkit.com> */
-
-#ifndef __optional_hpp__
-#define __optional_hpp__
-
-#include <policyrep/policy_base.hpp>
-
-namespace policyrep
-{
-	class OptionalBranch;
-	typedef boost::shared_ptr<OptionalBranch> OptionalBranchPtr;
-
-	struct OptionalBlockImpl;
-	class OptionalBlock : public PolicyBlock
-	{
-	public:
-		OptionalBlock();
-		OptionalBlock(const OptionalBlock& other);
-		OptionalBlock(OptionalBranchPtr true_);
-		OptionalBlock(OptionalBranchPtr true_, OptionalBranchPtr false_);
-		virtual ~OptionalBlock();
-		virtual void operator=(const OptionalBlock& other);
-	protected:
-		void copy(const OptionalBlock& other);
-		OptionalBlockImpl* impl;
-	};
-	typedef boost::shared_ptr<OptionalBlock> OptionalBlockPtr;
-
-	struct OptionalBranchImpl;
-	class OptionalBranch : public PolicyBranch
-	{
-	public:
-		OptionalBranch();
-		OptionalBranch(const OptionalBranch& other);
-		virtual ~OptionalBranch();
-		virtual void operator=(const OptionalBranch& other);
-		
-	protected:
-		virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
-		void copy(const OptionalBranch& other);
-		OptionalBranchImpl* impl;
-	};
-
-} // namespace policyrep
-
-#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
