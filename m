Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9JIX7Fl027697
	for <selinux@tycho.nsa.gov>; Fri, 19 Oct 2007 14:33:07 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l9JIX6oF008523
	for <selinux@tycho.nsa.gov>; Fri, 19 Oct 2007 18:33:06 GMT
Subject: error is expansion behavior
From: "J. Tang" <jtang@tresys.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 19 Oct 2007 14:33:08 -0400
Message-Id: <1192818788.2647.34.camel@venom.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There appears to be a problem with how semodule_expand handles aliases
within optional blocks.  Consider this module:

optional {
  require {
    type not_exist_in_base_t;
  }
  typealias not_exist_in_base_t alias bogus_alias_t;
}

The resulting expanded policy [correctly] does not contain
not_exist_in_base_t, but does have bogus_alias_t.  This is because
type_copy_callback() in expand.c calls is_id_enabled(), but
alias_copy_callback() does not.  The contents of the alias's value will
be set to zero because there is no entry in state's typemap for the
primary (line 479 of expand.c, libsepol 2.0.12).

In terms of everyday usage, this is not a problem because bogus_alias_t
will never be referenced.  However, tools that analyze policy by
iterating over hash tables (e.g., SETools) will fail because
bogus_alias_t's value is zero.  We suspect this is the cause of the
segfault reported in https://bugzilla.redhat.com/show_bug.cgi?id=336841,
for the targetted policy currently in rawhide has such an alias,
unconfined_mozilla_rw_t.

One solution is to check if newalias->s.value will be zero, and if so
then do not insert the alias into the hash table.  This seems brittle
because it relies on a side-effect of the typemap (i.e., unfulfilled
types have a value of zero).  Unfortunately, other solutions will
involve much more work.  What should be done about this problem, if any?

-- 
Jason Tang / jtang@tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
