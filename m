Subject: Re: libsemanage issue with bzip-blocksize=0 and compressed modules
 in store
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1251122072.2916.16.camel@defiant.pebenito.net>
References: <1251122072.2916.16.camel@defiant.pebenito.net>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 10:04:11 -0400
Message-Id: <1251122651.2428.23.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-08-24 at 09:54 -0400, Chris PeBenito wrote:
> I took the current release of libsemanage and added the patch to add a
> bzip blocksize option[1].  The modules in my store were already
> compressed with the stock release.  I put bzip-blocksize=0 in my
> semanage.conf and I do semodule -B and get:
> 
> libsepol.module_package_read_offsets: wrong magic number for module
> package:  expected 0xf97cff8f, got 0x39685a42 (No such file or
> directory).
> libsemanage.semanage_load_module: Error while reading from module
> file /etc/selinux/strict/modules/tmp/modules/apm.pp. (No such file or
> directory).
> semodule:  Failed!
> 
> If I do semodule -l, it will also get the magic number error.  If I
> remove the blocksize option, it works again.  I was able to reinsert all
> of the modules to get it working again with the blocksize 0 option.
> 
> [1] http://userspace.selinuxproject.org/trac/changeset/ee9827000137fed2d3300124115fc1572acafe2f

Yes, that's what I would expect.  The expectation is that either one
would set that option before installing the policy for the first time,
or that one completely re-installs the policy after setting that option.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
