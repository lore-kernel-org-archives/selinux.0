Message-ID: <45243804.80902@us.ibm.com>
Date: Wed, 04 Oct 2006 17:39:00 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: newrole - adding capabilities for polyinstantiation
References: <451AEC39.2090409@us.ibm.com>	 <1159450384.11489.5.camel@moss-spartans.epoch.ncsc.mil>	 <451C3A37.8080509@us.ibm.com>  <4522E6DA.1000200@us.ibm.com>	 <1159973532.19176.84.camel@moss-spartans.epoch.ncsc.mil>	 <4523E1E5.7030907@us.ibm.com> <1159980742.19176.140.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1159980742.19176.140.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2006-10-04 at 11:31 -0500, Michael C Thompson wrote:
>> Stephen Smalley wrote:
>>> That is not correct.  File system operations in Linux are based on the
>>> fsuid, which shadows the euid unless explicitly set.
>> hmm, you are right (and I, alas, was wrong). However, the files will be 
>> created with the egid being the calling user (as it stands). I imagine 
>> we'd want to change that.
> 
> Not clear that it matters.  IIUC, pam_namespace already sets the user
> and group ownership after creation, so the only reason we care about
> euid/fsuid is ensuring that the directory isn't temporarily accessible
> to the caller.  As long as the directory mode is owner-only (as I think
> it is), the initial gid on the directory shouldn't matter.
> 

 From pam_namespace.c:
mkdir(ipath, S_IRUSR)

After this, the security attributes of the directory are set according 
to those of the original with the appropriate uid/gid and perm mask.

So again, you are indeed correct. One of these days...!

Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
