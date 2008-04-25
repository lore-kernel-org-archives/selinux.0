Subject: audit2allow -R
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <jbrindle@tresys.com>
Content-Type: text/plain
Date: Fri, 25 Apr 2008 13:54:22 -0400
Message-Id: <1209146062.26761.173.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Per the man page, audit2allow -R is supposed to be the default.
And the code says:
        parser.add_option("-R", "--reference", action="store_true", dest="refpolicy",
                          default=True, help="generate refpolicy style output")

which seems to confirm that.  But running audit2allow w/o -R does not
generate interface calls.

On the next line, we have the opposite option:
        parser.add_option("-N", "--noreference", action="store_false", dest="refpolicy",
                          default=False, help="do not generate refpolicy style output")

I'm wondering if the default= value there is clobbering the prior one
and needs to get updated too if we actually want this to be the default.

But before we do that, do we truly want to make it the default?  How
confident are we in the interface matching?


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
