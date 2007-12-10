Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBAKwkx2022249
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2007 15:58:46 -0500
Received: from cadmus.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBAKwiqO009561
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2007 20:58:44 GMT
Date: Mon, 10 Dec 2007 15:58:43 -0500
From: "Todd C. Miller" <tmiller@tresys.com>
Message-Id: <200712102058.lBAKwh2P007932@cadmus.columbia.tresys.com>
To: selinux@tycho.nsa.gov
Subject: [POLICYREP] Add tunable support
Cc: tmiller@tresys.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds support for tunables to the policy language.  It is
based on the existing boolean support.

Signed-Off-By: Todd C. Miller <tmiller@tresys.com>

Index: libpolicyrep/tests/example.te
===================================================================
--- libpolicyrep/tests/example.te	(revision 2703)
+++ libpolicyrep/tests/example.te	(working copy)
@@ -33,6 +33,9 @@
 
 bool foo true;
 
+tunable bar true;
+tunable baz false;
+
 user foo_u roles bar_r;
 user fooyou_u roles bar_r level s1 range s1:c2 - s12:c3;
 user fubu_u roles bar_r level s1 range s3 - s13:c3,c5,c12.c34;
@@ -60,7 +63,30 @@
 
 optional {
 	 allow method foo : file execute;
+	 iftun (baz) {
+		allow method file : file getattr;
+	 }
 } else {
 	 allow pebenito foo : file execute;
+	 iftun (bar) {
+		allow pebenito file : file getattr;
+	 }
 }
 
+
+iftun (bar) {
+	allow method bar : file execute;
+	iftun (baz) {
+		 allow method bar : file getattr;
+	} else {
+		 allow pebenito bar : file getattr;
+	}
+	optional {
+		 allow method bar : file { read write };
+	} else {
+		 allow pebenito bar : file { read write };
+	}
+} else {
+	allow pebenito bar : file execute;
+}
+
Index: libpolicyrep/include/policyrep/tunable.hpp
===================================================================
--- libpolicyrep/include/policyrep/tunable.hpp	(revision 0)
+++ libpolicyrep/include/policyrep/tunable.hpp	(revision 0)
@@ -0,0 +1,145 @@
+/* Author: Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+#ifndef __tunable_hpp__
+#define __tunable_hpp__
+
+#include <policyrep/policy_base.hpp>
+
+#include <list>
+
+namespace policyrep
+{
+
+	/* Introduction
+	 *
+	 * Tunable policy in policyrep is handled in such a way that
+	 * the normal tree iteration works unchanged all the way to the
+	 * most nested leaf nodes. To achieve this the design is not
+	 * what might be most obvious.
+	 *
+	 * The tunable policy statements:
+	 *
+	 * iftun (foo) {
+	 *     allow foo_t bar_t : file read;
+	 * } else {
+	 *     allow baz_t bar_t : file write;
+	 * }
+	 *
+	 * Are encoded into the following tree struction:
+	 *
+	 * TunableBlock
+	 *     TunableBranch (with TunableExpr foo)
+	 *          AVRule
+	 *     TunableBranch (with else == true)
+	 *          AVRule
+	 *
+	 * The TunableBranches are just children of the TunableBlock,
+	 * but the TunableBlock has an overloaded add_child implementation
+	 * to prevent more than two children from being added.
+	 */
+
+	struct TunableBoolImpl;
+	class TunableBool : public Node
+	{
+	public:
+		TunableBool();
+		TunableBool(const std::string& name, bool v);
+		TunableBool(const TunableBool& other);
+		virtual ~TunableBool();
+		virtual void operator=(const TunableBool& other);
+
+		virtual void set_name(const std::string& name);
+		virtual const std::string& get_name() const;
+
+		virtual void set_default_value(bool v);
+		virtual bool get_default_value() const;
+	protected:
+		void copy(const TunableBool& other);
+		virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
+		TunableBoolImpl* impl;
+	};
+
+	class TunableOp;
+	std::ostream& operator<<(std::ostream& o, const TunableOp& op);
+
+	//
+	// TunableOp
+	//
+
+	struct TunableOpImpl;
+	class TunableOp
+	{
+	public:
+		enum Op { BOOL, NOT, OR, AND, XOR, EQ, NEQ };
+		TunableOp();
+		TunableOp(const std::string& b);
+		TunableOp(Op op);
+		TunableOp(const TunableOp& other);
+		virtual ~TunableOp();
+		virtual void operator=(const TunableOp& other);
+
+		virtual void set_op(Op op);
+		virtual Op get_op() const;
+
+		/* changes op to BOOL in addition to setting the tunable */
+		virtual void set_tunable(const std::string& b);
+		virtual const std::string& get_tunable() const;
+		friend std::ostream& operator<<(std::ostream& o, const TunableOp& op);
+
+	protected:
+		TunableOpImpl* impl;
+	};
+
+	//
+	// TunableExpr
+	//
+
+	typedef std::list<TunableOp> TunableExpr;
+
+	// forward declarations
+
+	class TunableBranch;
+	typedef boost::shared_ptr<TunableBranch> TunableBranchPtr;
+
+	//
+	// TunableBlock
+	//
+
+	struct TunableBlockImpl;
+	class TunableBlock : public PolicyBlock
+	{
+	public:
+		TunableBlock();
+		TunableBlock(TunableBranchPtr if_);
+		TunableBlock(TunableBranchPtr if_, TunableBranchPtr else_);
+		TunableBlock(const TunableBlock& other);
+		virtual ~TunableBlock();
+		virtual void operator=(const TunableBlock& other);
+	protected:
+		void copy(const TunableBlock& other);
+		TunableBlockImpl* impl;
+	};
+
+	//
+	// TunableBranch
+	//
+
+	struct TunableBranchImpl;
+	class TunableBranch : public PolicyBranch
+	{
+	public:
+		TunableBranch();
+		TunableBranch(const TunableBranch& other);
+		virtual ~TunableBranch();
+		virtual void operator=(const TunableBranch& other);
+
+		virtual TunableExpr& expr();
+	protected:
+		virtual void do_output(std::ostream& o, const OutputFormatter& op) const;
+		void copy(const TunableBranch& other);
+		TunableBranchImpl* impl;
+	};
+
+} // namespace policyrep
+
+#endif
Index: libpolicyrep/include/policyrep/policy.hpp
===================================================================
--- libpolicyrep/include/policyrep/policy.hpp	(revision 2703)
+++ libpolicyrep/include/policyrep/policy.hpp	(working copy)
@@ -12,6 +12,7 @@
 #include <policyrep/user.hpp>
 #include <policyrep/mls.hpp>
 #include <policyrep/optional.hpp>
+#include <policyrep/tunable.hpp>
 
 namespace policyrep
 {
Index: libpolicyrep/src/policy_scan.l
===================================================================
--- libpolicyrep/src/policy_scan.l	(revision 2703)
+++ libpolicyrep/src/policy_scan.l	(working copy)
@@ -92,6 +92,8 @@
 type				{ return token::TYPE; }
 BOOL |
 bool                            { return token::BOOL; }
+TUNABLE |
+tunable                         { return token::TUNABLE; }
 IF |
 if				{ return token::IF; }
 ELSE |
@@ -145,6 +147,7 @@
 module|MODULE                   { return token::MODULE; }
 require|REQUIRE                 { return token::REQUIRE; }
 optional|OPTIONAL               { return token::OPTIONAL; }
+iftun|IFTUN                     { return token::IFTUN; }
 OR |
 or     			        { return token::OR;}
 AND |
Index: libpolicyrep/src/policy_parse.y
===================================================================
--- libpolicyrep/src/policy_parse.y	(revision 2703)
+++ libpolicyrep/src/policy_parse.y	(working copy)
@@ -85,6 +85,8 @@
 	CondExpr* cond_expr;
 	CondBranch* cond_branch;
 	OptionalBranch* optional_branch;
+	TunableExpr* tunable_expr;
+	TunableBranch* tunable_branch;
 	bool bval;
 }
 
@@ -139,6 +141,9 @@
 %type <pnode> bool_def
 %type <pnode> optional_block_def
 %type <pnode> optional_statement
+%type <pnode> tunable_def
+%type <pnode> tunable_block_def
+%type <pnode> tunable_statement
 
 
 %type <cond_branch> cond_else
@@ -146,10 +151,16 @@
 
 %type <optional_branch> optional_statements
 
+%type <tunable_branch> tunable_statements
+
 %type <cond_expr> cond_expr
 
+%type <tunable_expr> tunable_expr
+
 %type <bval> bool_val
 
+%type <bval> tunable_val
+
 %token END 0
 %token <id> PATH
 %token CLONE
@@ -168,6 +179,8 @@
 %token ALIAS
 %token ATTRIBUTE
 %token BOOL
+%token TUNABLE
+%token IFTUN
 %token IF
 %token ELSE
 %token TYPE_TRANSITION
@@ -277,6 +290,9 @@
 			| cond_block_def
 			/* optional policy */
 			| optional_block_def
+			/* tunable policy */
+			| tunable_def
+			| tunable_block_def
 			;
 ignored_policy_statement: require_block
 			;
@@ -468,7 +484,80 @@
 			| bool_def
 			| cond_block_def
 			/* optional policy */
+			| optional_block_def
+			/* tunable policy */
+			| tunable_def
+			| tunable_block_def
 			;
+tunable_def		: TUNABLE IDENTIFIER tunable_val SEMI
+			  { $$ = new TunableBool(*$2, $3); delete $2; }
+			;
+tunable_val		: CTRUE { $$ = true; }
+			| CFALSE { $$ = false; }
+			;
+tunable_block_def	: IFTUN tunable_expr LBRACE tunable_statements RBRACE ELSE LBRACE tunable_statements RBRACE
+			  { $4->expr() = *$2; delete $2; $$ = new TunableBlock(TunableBranchPtr($4), TunableBranchPtr($8)); }
+			| IFTUN tunable_expr LBRACE tunable_statements RBRACE
+			  { $4->expr() = *$2; delete $2; $$ = new TunableBlock(TunableBranchPtr($4)); }
+			;
+tunable_expr		: LPAREN tunable_expr RPAREN
+			  { $$ = $2; }
+			| NOT tunable_expr
+			  { $2->push_front(TunableOp(TunableOp::NOT)); $$ = $2; }
+			| tunable_expr AND tunable_expr
+			  { $1->push_back(TunableOp(TunableOp::AND));
+			    $1->insert($1->end(), $3->begin(), $3->end());
+			    $$ = $1; }
+			| tunable_expr OR tunable_expr
+			  { $1->push_back(TunableOp(TunableOp::OR));
+			    $1->insert($1->end(), $3->begin(), $3->end());
+			    $$ = $1; }
+			| tunable_expr XOR tunable_expr
+			  { $1->push_back(TunableOp(TunableOp::XOR));
+			    $1->insert($1->end(), $3->begin(), $3->end());
+			    $$ = $1; }
+			| tunable_expr EQUALS tunable_expr
+			  { $1->push_back(TunableOp(TunableOp::EQ));
+			    $1->insert($1->end(), $3->begin(), $3->end());
+			    $$ = $1; }
+			| tunable_expr NOTEQUAL tunable_expr
+			  { $1->push_back(TunableOp(TunableOp::NEQ));
+			    $1->insert($1->end(), $3->begin(), $3->end());
+			    $$ = $1; }
+			| IDENTIFIER
+			  { $$ = new TunableExpr(); $$->push_back(TunableOp(*$1)); delete $1; }
+			;
+tunable_statements	: tunable_statement
+			  { TunableBranch* b = new TunableBranch; b->append_child(NodePtr($1)); $$ = b; }
+			| ignored_policy_statement
+			  { $$ = new TunableBranch; }
+			| tunable_statement tunable_statements
+			  { $2->append_child(NodePtr($1)); $$ = $2; }
+			| ignored_policy_statement tunable_statements
+			  { $$ = $2; }
+			;
+tunable_statement       : class_def
+			/* TE decl */
+			| attribute_def
+			| type_def
+			| typealias_def
+			| typeattribute_def
+			/* rules */
+			| allow_def
+			| auditallow_def
+			| auditdeny_def
+			| dontaudit_def
+			| neverallow_def
+			| transition_def
+			/* conditional policy */
+			| bool_def
+			| cond_block_def
+			/* optional policy */
+			| optional_block_def
+			/* tunable policy */
+			| tunable_def
+			| tunable_block_def
+			;
 transition_def		: TYPE_TRANSITION names names COLON names IDENTIFIER SEMI
 			  { $$ = define_typerule(TypeRule::TRANSITION, $2, $3, $5, $6, driver); }
                         | TYPE_MEMBER names names COLON names IDENTIFIER SEMI
Index: libpolicyrep/src/tunable.cpp
===================================================================
--- libpolicyrep/src/tunable.cpp	(revision 0)
+++ libpolicyrep/src/tunable.cpp	(revision 0)
@@ -0,0 +1,306 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <policyrep/tunable.hpp>
+#include "policy_base_internal.hpp"
+
+#include <list>
+#include <stdexcept>
+
+namespace policyrep
+{
+	//
+	// TunableBool
+	//
+
+	struct TunableBoolImpl
+	{
+		std::string name;
+		bool default_value;
+	};
+
+	TunableBool::TunableBool() : impl(new TunableBoolImpl)
+	{
+
+	}
+
+	TunableBool::TunableBool(const std::string& name, bool v)
+		: impl(new TunableBoolImpl)
+	{
+		impl->name = name;
+		impl->default_value = v;
+	}
+
+	TunableBool::TunableBool(const TunableBool& other) : Node(), impl(new TunableBoolImpl)
+	{
+		copy(other);
+	}
+
+	TunableBool::~TunableBool()
+	{
+		delete impl;
+	}
+
+	void TunableBool::operator=(const TunableBool& other)
+	{
+		copy(other);
+	}
+
+	void TunableBool::set_name(const std::string& name)
+	{
+		impl->name = name;
+	}
+
+	const std::string& TunableBool::get_name() const
+	{
+		return impl->name;
+	}
+
+	void TunableBool::set_default_value(bool v)
+	{
+		impl->default_value = v;
+	}
+
+	bool TunableBool::get_default_value() const
+	{
+		return impl->default_value;
+	}
+
+	void TunableBool::do_output(std::ostream& o, const OutputFormatter& op) const
+	{
+		o << "tunable " << impl->name << " ";
+		if (impl->default_value)
+			o << "true;";
+		else
+			o << "false;";
+	}
+
+	void TunableBool::copy(const TunableBool& other)
+	{
+		Node::copy(other);
+		*impl = *other.impl;
+	}
+
+	//
+	// TunableOp
+	//
+
+	struct TunableOpImpl
+	{
+		TunableOpImpl() : op(TunableOp::AND) { }
+		TunableOp::Op op;
+		std::string b;
+	};
+
+	TunableOp::TunableOp() : impl(new TunableOpImpl)
+	{
+
+	}
+
+	TunableOp::TunableOp(const std::string& b) : impl(new TunableOpImpl)
+	{
+		impl->op = BOOL;
+		impl->b = b;
+	}
+
+	TunableOp::TunableOp(Op op) : impl(new TunableOpImpl)
+	{
+		impl->op = op;
+	}
+
+	TunableOp::TunableOp(const TunableOp& other) : impl(new TunableOpImpl)
+	{
+		*impl = *other.impl;
+	}
+
+	TunableOp::~TunableOp()
+	{
+		delete impl;
+	}
+
+	void TunableOp::operator=(const TunableOp& other)
+	{
+		*impl = *other.impl;
+	}
+
+	void TunableOp::set_tunable(const std::string& b)
+	{
+		impl->b = b;
+	}
+
+	const std::string& TunableOp::get_tunable() const
+	{
+		return impl->b;
+	}
+
+	void TunableOp::set_op(Op op)
+	{
+		impl->op = op;
+	}
+
+	TunableOp::Op TunableOp::get_op() const
+	{
+		return impl->op;
+	}
+
+	std::ostream& operator<<(std::ostream& o, const TunableOp& op)
+	{
+		switch (op.get_op()) {
+		case TunableOp::BOOL:
+			o << op.get_tunable();
+			break;
+		case TunableOp::NOT:
+			o << "!";
+			break;
+		case TunableOp::OR:
+			o << "|";
+			break;
+		case TunableOp::AND:
+			o << "&";
+			break;
+		case TunableOp::XOR:
+			o << "^";
+			break;
+		case TunableOp::EQ:
+			o << "==";
+			break;
+		case TunableOp::NEQ:
+			o << "!=";
+			break;
+		};
+
+		return o;
+	}
+
+	//
+	// TunableBlock
+	//
+
+	struct TunableBlockImpl { };
+
+	TunableBlock::TunableBlock() : impl(new TunableBlockImpl)
+	{
+
+	}
+
+	TunableBlock::TunableBlock(TunableBranchPtr if_) : impl(new TunableBlockImpl)
+	{
+		append_child(if_);
+	}
+
+	TunableBlock::TunableBlock(TunableBranchPtr if_, TunableBranchPtr else_) : impl(new TunableBlockImpl)
+	{
+		append_child(if_);
+		append_child(else_);
+	}
+
+	TunableBlock::TunableBlock(const TunableBlock& other) : PolicyBlock(), impl(new TunableBlockImpl)
+	{
+		copy(other);
+	}
+
+	TunableBlock::~TunableBlock()
+	{
+		delete impl;
+	}
+
+	void TunableBlock::operator=(const TunableBlock& other)
+	{
+		copy(other);
+	}
+
+	void TunableBlock::copy(const TunableBlock& other)
+	{
+		PolicyBlock::copy(other);
+		*impl = *other.impl;
+	}
+
+
+	//
+	// TunableBranch
+	//
+
+	struct TunableBranchImpl
+	{
+		TunableExpr expr;
+	};
+
+	TunableBranch::TunableBranch() : impl(new TunableBranchImpl)
+	{
+
+	}
+
+	TunableBranch::TunableBranch(const TunableBranch& other) : PolicyBranch(), impl(new TunableBranchImpl)
+	{
+		copy(other);
+	}
+
+	TunableBranch::~TunableBranch()
+	{
+		delete impl;
+	}
+
+	void TunableBranch::operator=(const TunableBranch& other)
+	{
+		copy(other);
+	}
+
+	TunableExpr& TunableBranch::expr()
+	{
+		return impl->expr;
+	}
+
+	void TunableBranch::do_output(std::ostream& o, const OutputFormatter& op) const
+	{
+		if (op.get_end()) {
+			o << "}";
+		} else {
+			if (get_isfalse()) {
+				o << "else {";
+			} else {
+				o << "iftun (";
+				
+				TunableExpr::iterator i, end;
+				i = impl->expr.begin();
+				end = impl->expr.end();
+				bool first = true;
+			
+				for (; i != end; ++i) {
+					if (first)
+						first = false;
+					else
+						o << " ";
+					
+					o << *i;
+				}
+				
+				o << ") {";
+			}
+		}
+
+	}
+
+	void TunableBranch::copy(const TunableBranch& other)
+	{
+		PolicyBranch::copy(other);
+		*impl = *other.impl;
+	}
+
+}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
