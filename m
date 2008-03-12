Subject: Re: [PATCH] SELinux: requesting no permissions in
	avc_has_perm_noaudit is a BUG()
From: Eric Paris <eparis@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.64.0803120924590.26039@us.intercode.com.au>
References: <1205259574.5297.107.camel@localhost.localdomain>
	 <Xine.LNX.4.64.0803120916170.21778@us.intercode.com.au>
	 <Xine.LNX.4.64.0803120924590.26039@us.intercode.com.au>
Content-Type: text/plain
Date: Wed, 12 Mar 2008 12:44:28 -0400
Message-Id: <1205340268.5297.194.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-03-12 at 09:26 +1100, James Morris wrote:
> On Wed, 12 Mar 2008, James Morris wrote:
> 
> > Applied to 
> > git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm
> 
> Just saw this during boot.
> 
> [    8.238863] ------------[ cut here ]------------
> [    8.239762] kernel BUG at security/selinux/avc.c:874!

turns out this is easy to reproduce.

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(void)
{
	open("/dev/null", 3);
	return 0;
}

I'm testing a new patch which once I full understand I'll send upstream
to see what they have to say...

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
