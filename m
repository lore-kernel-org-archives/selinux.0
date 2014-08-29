Message-ID: <54006DD4.6040706@tycho.nsa.gov>
Date: Fri, 29 Aug 2014 08:11:00 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: SELinux Userspace Release: 20140826-rc1
References: <53FCA845.1030001@tresys.com> <20140827150608.GA6701@siphos.be>
 <53FE02E5.6080506@tresys.com>
 <CAPzO=NyyP-m8jPBujd-vnG9XHo2FymskgQBH3fKPt448NznZdA@mail.gmail.com>
 <53FF8DE9.6070302@tycho.nsa.gov>
 <CAPzO=Nwwbn8ihZmuj-JGKPUonZwjS69Zjg=1ix1EDbR=QQ56oQ@mail.gmail.com>
In-Reply-To: <CAPzO=Nwwbn8ihZmuj-JGKPUonZwjS69Zjg=1ix1EDbR=QQ56oQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/28/2014 04:52 PM, Sven Vermeulen wrote:
> On Thu, Aug 28, 2014 at 10:15 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> When running the semanage_migrate_script I get the following problem:
>>>
>>> Migrating from /etc/selinux/mcs/modules/active to /var/lib/selinux/mcs/active
>>> Attempting to rebuild policy from /var/lib/selinux
>>> sysnetwork: Warning: 'else' blocks in optional statements are
>>> unsupported in CIL. Dropping from output.
>>> Segmentation fault
> [...]
>> Can you provide a copy of your original policy prior to conversion?
> 
> If you mean the policy.29 file, certainly. You can wget it from
> http://dev.gentoo.org/~swift/tmp/20140828-policy.29

No, the contents of /etc/selinux/mcs.  The migration script converts the
old policy module store, not the final kernel policy file.
