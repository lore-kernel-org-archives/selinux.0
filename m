Message-ID: <1492783138.26658.3.camel@tycho.nsa.gov>
Subject: Re: Updating offline the commit_num file
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eduardo Barretto <ebarreto@linux.vnet.ibm.com>, selinux@tycho.nsa.gov
Date: Fri, 21 Apr 2017 09:58:58 -0400
In-Reply-To: <6731786d-a352-ce4b-b212-3b85735b571f@linux.vnet.ibm.com>
References: <6731786d-a352-ce4b-b212-3b85735b571f@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-04-20 at 17:52 -0300, Eduardo Barretto wrote:
> Hi all,
> 
> I'm trying to do an offline update (i.e. issuing the semanage
> command)
> of some files on SELinux, and then replace those files on the system
> that is being updated.
> 
> I know that the semanage also updates the commit_num file. So my
> doubt is:
> 
> Do I need to care about updating the commit_num on the updated
> system?
> Should I increment the commit_num by the same amount (resulted from
> the
> semanage command) that the updated files where ?
> 
> Is there any code that is reading the value in the commit_num file
> and
> if so, how is it using the value read?
> 
> If this is not the correct place to get this information, just let me
> know.

Any particular reason you are doing it this way instead of running the
commands on the build host, doing a semanage export and then doing a
semanage import on the target system?

Are you doing anything to prevent another process on the system from
performing transactions on the policy store at the same time you are
replacing the files?

Are you dealing with differences in policy store location and content
(if you are running the semanage command on a system running a
different version than any of the systems being updated)? This differs
even just going from RHEL7.2 to RHEL7.3, and differs between Fedora and
RHEL (e.g. /var/lib/selinux vs /etc/selinux, changes to the underlying
directory structure, changing from binary modules to CIL modules).

With regard to commit_num, the only property you need to preserve is
that it monotonically increases.  The actual value isn't so important. 
So if all policy changes are performed in this manner, you could just
copy the commit_num file as is from the server. Or if you are making
local changes as well, then you just need to ensure that you increment
the commit_num each time you update the files; you don't need to
increment it by the same amount as on the server (i.e. we don't care
about tracking the individual changes).
