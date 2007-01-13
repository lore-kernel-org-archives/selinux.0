From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Antill <james.antill@redhat.com>
Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
Date: Sat, 13 Jan 2007 21:55:28 +1100
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Jim Meyering <meyering@redhat.com>
References: <45A7D773.8040800@redhat.com> <1168633494.7993.546.camel@moss-spartans.epoch.ncsc.mil> <1168636513.13080.227.camel@code.and.org>
In-Reply-To: <1168636513.13080.227.camel@code.and.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200701132155.31969.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 13 January 2007 08:15, James Antill <james.antill@redhat.com> 
wrote:
> newcon = getfilecon("old")
> setfscreatecon(newcon);
> [...]
> fd = open("new");
> con = getfscreatecon();
> fsetfilecon(fd, con);
>
> ...the later of which, I think, does nothing useful atm.

touch /tmp/foo
cp -Z CONTEXT /tmp/bar /tmp/foo

Some time ago I reported a bug in cp -Z whereby setfscreatecon() was used but 
it didn't work when the file existed.  The above commands would not give the 
desired result for example.

I haven't looked at the cp source recently, might there be some similar corner 
case prevented by this double set?

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
