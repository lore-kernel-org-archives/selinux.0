Message-ID: <532C3F5F.1040602@tycho.nsa.gov>
Date: Fri, 21 Mar 2014 09:32:15 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: kim.lawson-jenkins@nrl.navy.mil, selinux@tycho.nsa.gov
Subject: Re: How to restore a policy module
References: <01e101cf4509$9942ae60$cbc80b20$@nrl.navy.mil>
In-Reply-To: <01e101cf4509$9942ae60$cbc80b20$@nrl.navy.mil>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/21/2014 09:29 AM, Kim Lawson-Jenkins wrote:
> In an attempt to lockdown a system I removed the remotelogin policy
> module using semodule –r.  I’m using the targeted policy on RHEL6.  How
> do I add this file back to my current configuration?

You can always do a yum reinstall selinux-policy-targeted to fully
reinstall the policy, or you could individually install that policy
module.  Used to be the case that a copy of each module was available
under /usr/share/selinux/targeted, so you could do a semodule -i
/usr/share/selinux/targeted/remotelogin.pp if that exists (but it seems
to have gone away in recent Fedora, likely to save on storage).
