Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s31CnJap004591
 for <selinux@tycho.nsa.gov>; Tue, 1 Apr 2014 08:49:19 -0400
Message-ID: <533AB5CB.8090304@redhat.com>
Date: Tue, 01 Apr 2014 08:49:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Andy Ruch <adruch2002@yahoo.com>, SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: SSSD on a read-only filesystem
References: <1396303709.28726.YahooMailNeo@web124903.mail.ne1.yahoo.com>
In-Reply-To: <1396303709.28726.YahooMailNeo@web124903.mail.ne1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

No the only potential problem with this would be is if you setup
Confined Users to be provided by something like IPA, and sssd was not
able to contact the IPA server after a reboot.  Then potentially a user
would be allowed to login with a different user domain.

IE It will fallback to the __default__ user.

On 03/31/2014 06:08 PM, Andy Ruch wrote:
> Hello,
>
> I'm implementing SSSD on my RHEL 6.5 system with a read-only root filesystem. SSSD attempts to write a file to /etc/selinux/<policy>/logins that maps the linux user to an selinux user. However, this causes problems since /etc is read-only. I've played with mounting /etc/selinux/<policy>/logins in tmpfs and everything seems to work. My questions really comes down to:
>
>
> 1) Are there any security concerns with having the 'logins' directory in tmpfs? 
>
>
> 2) Are there any functional considerations if the 'logins' directory gets erased every time the system reboots?
>
>
>
> Thanks,
> Andy Ruch
>
