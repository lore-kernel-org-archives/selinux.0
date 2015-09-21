Subject: Re: how to run setsebool -P in chroot?
To: Bond Masuda <bond.masuda@jlbond.com>, selinux@tycho.nsa.gov
References: <CA+=dQ-8E2jMNN0i5=Bomp3g=hkFN=_qiQ3G5UtiXU8rNm6Ap1A@mail.gmail.com>
 <20150911134151.GA6297@x250> <55FC9E8B.8000604@jlbond.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56006495.8080003@tycho.nsa.gov>
Date: Mon, 21 Sep 2015 16:12:05 -0400
MIME-Version: 1.0
In-Reply-To: <55FC9E8B.8000604@jlbond.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/18/2015 07:30 PM, Bond Masuda wrote:
> Hello,
> 
> I'm trying to run setsebool in a chroot environment like:
> 
> chroot /mnt/test /usr/sbin/setsebool -P antivirus_can_scan_system 1
> 
> But I get:
> 
> setsebool:  SELinux is disabled.
> 
> I'm guessing this is because the environment is not running. Is there a
> way around this? I need to be able to set some of the booleans this way.

I would try using semanage boolean -N instead of setsebool -P.
