Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6UDQ9rT027014
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 09:26:09 -0400 (EDT)
Received: from smtp810.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6UDPbTf022683
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 13:25:38 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp810.mail.ukl.yahoo.com with SMTP; 30 Jul 2004 13:26:07 -0000
Date: Fri, 30 Jul 2004 14:37:11 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: pear-shaped behaviour after enough make reloads
Message-ID: <20040730133711.GM16866@lkcl.net>
References: <20040728211229.GB18711@lkcl.net> <1091126965.21971.160.camel@moss-spartans.epoch.ncsc.mil> <20040729202419.GI9950@lkcl.net> <1091133123.21971.200.camel@moss-spartans.epoch.ncsc.mil> <20040729221824.GR9950@lkcl.net> <1091190420.21245.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091190420.21245.37.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

okay, i had the same symptoms happening as i originally described,
and was alert to it this time.

what i had done was install a package with se_apt-get and that package
(autofs) attempted to overwrite /etc/modutils.conf.old (which failed)
and to overwrite /lib/modules/modprobe.conf.old (which also failed).

what i did was to give up, and use apt-get to recover (after deleting
the two .old files) with the intention of manually running
dpkg -L autofs | setfiles -q -s /etc/selinux/file_contexts/file_contexts
afterwards.

... except i didn't get that far, because of errors with ldconfig!

presumably, not only had the installation of autofs done a modules
update, but also it had done a ldconfig - in the wrong security
context.

so when i tried to do ldconfig again, it gave errors about cannot write
/etc/ld.so.cache~

after i had done setfiles /etc/selinux/file_contexts/file_contexts /
(which is a small root partition) i was able to run ldconfig again.

and the computer didn't go pear-shaped, this time.

so, stephen, i owe you an apology for taking up your time on this one.
[but it won't stop me from raising any other issues i find, just in
case]

i _would_ go and upgrade the packages like coreutils etc. like 
russell recommended, which i believe may fix this issue... it's
just that i might also have to upgrade the policy files and i'm
at present a looonng way from the default selinux policy stuff :)

l.

On Fri, Jul 30, 2004 at 08:27:00AM -0400, Stephen Smalley wrote:
> On Thu, 2004-07-29 at 18:18, Luke Kenneth Casson Leighton wrote:
> > for completeness on list, i should mention that i was modifying
> > policy files during the make reloads.
> > 
> > stephen mentioned that apparently if inodes are using a SID
> > that is deleted, no amount of subsequent make reloads will
> > reattach the SID to that inode.
> > 
> > what happened because of what i was doing to my computer "fits"
> > with this explanation.
> 
> Note that the invalidation of security contexts should have been logged
> in /var/log/messages upon the policy reload, e.g.
> cd /etc/selinux/strict/src/policy
> echo "type foo_t, file_type, sysadmfile;" > domains/misc/local.te
> touch /tmp/foo
> chcon -t foo_t /tmp/foo
> rm domains/misc/local.te
> make clean load
> 
> will yield the following in /var/log/messages or dmesg output for the
> final load:
> security:  5 users, 7 roles, 1302 types, 2 bools
> security:  52 classes, 319241 rules
> security:  invalidating context root:object_r:foo_t
> 
> At this point, the kernel will treat any incore inodes (or processes, if
> this were a domain rather than a file type) that had the type as having
> the unlabeled SID, and start denying access.  A ls -Z /tmp/foo will
> still show the original context (root:object_r:foo_t), because it is
> simply using getxattr to get the extended attribute value from the disk,
> and this has not changed, but the kernel no longer has any way of
> mapping this value to a meaningful representation in the policy.  But
> re-adding the type to the policy won't immediately update the incore
> inode's SID; that won't happen until the inode is evicted and
> re-instantiated or someone explicitly "relabels" it (but note that chcon
> and setfiles likely won't touch it, as they will still see the extended
> attribute value as being correct already and refrain from relabeling
> it).
> 
> -- 
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency
> 

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
