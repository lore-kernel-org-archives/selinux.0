Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2LDhRSv027254
 for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2014 09:43:27 -0400
Received: from ferret (fw5540.nrl.navy.mil [132.250.196.100])
 by ccs.nrl.navy.mil (8.14.4/8.14.4) with ESMTP id s2LDhR73005673
 for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2014 09:43:27 -0400
From: "Kim Lawson-Jenkins" <kim.lawson-jenkins@nrl.navy.mil>
To: <selinux@tycho.nsa.gov>
References: <01e101cf4509$9942ae60$cbc80b20$@nrl.navy.mil>
 <532C3F5F.1040602@tycho.nsa.gov> <532C400E.8090104@tycho.nsa.gov>
In-Reply-To: <532C400E.8090104@tycho.nsa.gov>
Subject: RE: How to restore a policy module
Date: Fri, 21 Mar 2014 09:49:32 -0400
Message-ID: <01e901cf450c$6391fe30$2ab5fa90$@nrl.navy.mil>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Reply-To: kim.lawson-jenkins@nrl.navy.mil
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks everyone for the rapid answers.  I was able to restore the file.

Kim

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Friday, March 21, 2014 9:35 AM
To: kim.lawson-jenkins@nrl.navy.mil; selinux@tycho.nsa.gov
Subject: Re: How to restore a policy module

On 03/21/2014 09:32 AM, Stephen Smalley wrote:
> On 03/21/2014 09:29 AM, Kim Lawson-Jenkins wrote:
>> In an attempt to lockdown a system I removed the remotelogin policy 
>> module using semodule -r.  I'm using the targeted policy on RHEL6.  
>> How do I add this file back to my current configuration?
> 
> You can always do a yum reinstall selinux-policy-targeted to fully 
> reinstall the policy, or you could individually install that policy 
> module.  Used to be the case that a copy of each module was available 
> under /usr/share/selinux/targeted, so you could do a semodule -i 
> /usr/share/selinux/targeted/remotelogin.pp if that exists (but it 
> seems to have gone away in recent Fedora, likely to save on storage).

Also, if you add:
save-previous = true
to your /etc/selinux/semanage.conf
it will keep a copy of your previous policy under
/etc/selinux/targeted/modules/previous on each transaction, making it easier
to rollback changes.
