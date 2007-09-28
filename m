Message-ID: <46FD0870.70801@redhat.com>
Date: Fri, 28 Sep 2007 09:58:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Todd C. Miller" <tmiller@tresys.com>, selinux@tycho.nsa.gov,
        jbrindle@tresys.com
Subject: Re: [patch 0/4] libsemanage: genhomedircon regressions
References: <20070927200712.950671948@tresys.com>	 <1190986603.22078.1.camel@moss-spartans.epoch.ncsc.mil> <1190987098.22078.4.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1190987098.22078.4.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Fri, 2007-09-28 at 09:36 -0400, Stephen Smalley wrote:
>> On Thu, 2007-09-27 at 16:07 -0400, Todd C. Miller wrote:
>>> This patch set fixes several regressions found in the new genhomedircon
>>> replacement.  I've broken things up into their logical parts for easy
>>> reading.  I've also included Dan's do_rebuild_file_context and swigify
>>> patches as a 4th diff.  If we want to treat that completely separately
>>> we can.
>> patch 1/4 yielded a non-buildable tree, so I applied 1/4 and 3/4
>> together as a single commit.
>>
>> 2/4 applied as a bug fix independent of the others.
>>
>> 4/4 dropped except for Makefile swigify target.
>>
>> libsemanage 2.0.10.
> 
> Looking again at the output, the order differs - the libsemanage
> genhomedircon puts the specific user entries first and then the
> generic /home entries, which seems wrong given that later entries take
> precedence for matchpathcon.  genhomedircon script does the opposite.
> 

It should be alright because of the specificity is greater.

/home/dwalsh/.*

vs

/home/.*
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG/QhwrlYvE4MpobMRAs9nAKCBvu1gSUsxBfLLkwCfLeSU7ejQxgCfcYd+
8i2BugMuBIPJl+UUW5GX6rw=
=Uyti
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
