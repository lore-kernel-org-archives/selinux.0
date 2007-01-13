From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: casey@schaufler-ca.com
Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
Date: Sat, 13 Jan 2007 20:13:03 +1100
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
References: <360757.85439.qm@web36610.mail.mud.yahoo.com>
In-Reply-To: <360757.85439.qm@web36610.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701132013.04807.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 13 January 2007 09:29, Casey Schaufler <casey@schaufler-ca.com> 
wrote:
> of design. The traditional rule that mv
> maintains attributes while cp use what the
> current process would do holds with (most)
> MAC systems.

Do "most" systems have a copy of MV that preserves MAC attributes (and 
therefore is a privileged process)?  Or are you just referring to the case of 
moving files within a filesystem?

I can imagine the benefits in having mv and cp preserve the context of files, 
and it shouldn't be difficult to implement.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
