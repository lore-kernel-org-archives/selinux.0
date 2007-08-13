Subject: Re: wrong magic number (using old sources)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux770@tortenboxer.de
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070811180730.308640@gmx.net>
References: <20070810101003.128080@gmx.net>
	 <1186746338.7233.11.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810121259.128050@gmx.net>
	 <1186748504.7233.34.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810130703.128070@gmx.net>
	 <1186751971.7233.70.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810141236.128070@gmx.net>  <20070811180730.308640@gmx.net>
Content-Type: text/plain
Date: Mon, 13 Aug 2007 08:55:18 -0400
Message-Id: <1187009718.26008.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-08-11 at 20:07 +0200, selinux770@tortenboxer.de wrote:
> Hello again,
> 
> unfortunately, the problem persists. I've compiled the current stable
> package and put the files on the target syste... the error is still
> "wrong magic number"...
> I also recompiled the kernel... btw... is this necessary each time i
> change the SELinux libraries versions? I did that too many times the
> last week ;-)

No, you don't have to do that.

> I've got to confess it was just a quick shot, maybe i forgot
> something, but I don't think so. I'll retry it on monday once a again,
> but I'm not very confident.
> 
> Is there some non-SELinux related library that may be responsible for
> this error? How is the magic number generated? How is it checked? Is
> some calculation or transformation performed on this number by other
> libraries? Since I cross-compile all the packages it may be the case
> that some libraries differ on the compiling system and the using
> system. It would be helpful to have a list to check these
> packages/libraries against inconsistencies that may be responsible for
> that.... 

libsepol/src/write.c:policydb_write() writes the policy image from
memory to disk.  If you look at it, you'll see that it puts the magic
number (just a fixed value, defined as POLICYDB_MAGIC) and the length of
a string identifier into a buffer (converting both to little endian
order), then puts them to the file via put_entry().

libsepol/src/policydb.c:policydb_read() reads the policy image from disk
into memory.  If you look at it, you'll see that it fetches the first
two words via next_entry(), converts them from little endian to cpu
order, and then checks the magic number to see whether it is a kernel
policy or a policy module, displaying the error message you are seeing
if it doesn't match either.

Are you cross-compiling from a system with different endianness?

As I've suggested before, you could send your policy.conf and policy.20
files to me separately and I could see whether I can reproduce here.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
