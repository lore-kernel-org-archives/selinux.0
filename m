Subject: Re: Compile error with the SVN version of the refpolicy.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ryan Bradetich <rbradetich@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e739902b0702200737g692dde82j10b75cfe20cb2f6@mail.gmail.com>
References: <e739902b0702162219o45a8ccc9v5e5092c9e310c4bb@mail.gmail.com>
	 <1171981486.14363.13.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0702200737g692dde82j10b75cfe20cb2f6@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 10:42:08 -0500
Message-Id: <1171986128.14363.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 07:37 -0800, Ryan Bradetich wrote:
> Hello Stephen,
> 
> I had used the package from the Ubuntu Feisty repository which is
> version 1.32-1.  I will revert my patch in my local tree and use the
> source from the SVN  checkpolicy from sourceforge.
> 
> Thanks for your response!

Yes, 1.32 wouldn't have that change.  1.34 is available from the last
nsa.gov/selinux release, so you could use that one, or you can use the
sourceforge svn tree.  Note that there is a stable branch in the
sourceforge svn tree that you may want to track rather than the trunk.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
