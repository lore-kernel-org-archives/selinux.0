Subject: Re: sepcut is broken
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Mark Shakespeare <mshakes@llnl.gov>, SELinux List <SELinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>, Russell Coker <russell@coker.com.au>
In-Reply-To: <1074792957.27824.101.camel@colossus.columbia.tresys.com>
References: <p0602040cbc34b0d29bb3@[128.115.96.64]>
	 <1074789931.27824.87.camel@colossus.columbia.tresys.com>
	 <1074792409.13445.148.camel@moss-spartans.epoch.ncsc.mil>
	 <1074792957.27824.101.camel@colossus.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1074795898.13445.196.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 22 Jan 2004 13:24:58 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-01-22 at 12:35, Karl MacMillan wrote:
> I think that sounds like a better solution as well. Any thoughts on the
> specifics of the format? A file with just a list of module file names
> would work and be simple for the make process to use, but now is a good
> time to consider if any other information should be included in the
> file. Additionally, this could allow developers to group .te files in
> subdirectories if they wanted some more organization.

The kernel configuration just specifies option values, and the kernel
Makefiles specify the lists of object files to be built based on those
option values.  We could eliminate the indirection for the policy, i.e.
one option per optional .te file.  The list of core policy .te files
could be specified in the Makefile, and the build process could then
just add the contents of the .config file to that list to produce the
full list of enabled .te files.  A 'make config' could automatically
enable all dependencies when you enable a .te file based on the Depends
lines in the optional .te files.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
