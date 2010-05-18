Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4ICdOdE017486
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2010 08:39:24 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o4ICcPTZ012155
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2010 12:38:26 GMT
Message-ID: <4BF28A59.402@redhat.com>
Date: Tue, 18 May 2010 08:38:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: TaurusHarry <harrytaurus2002@hotmail.com>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Re: How to cross install policy store?
References: <BAY111-W21E4613ED1D1458B53C3A6ABE10@phx.gbl>
In-Reply-To: <BAY111-W21E4613ED1D1458B53C3A6ABE10@phx.gbl>
Content-Type: text/plain; charset=GB2312
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/18/2010 03:07 AM, TaurusHarry wrote:
> 
> HI SELinux experts,
> 
> I am trying to use SELinux on an ARM board with limited RAM <=128m, if I use semodule tool to create policy store on the target it will be terminated by kernel OOM killer. Normally semodule tool will install the policy store on the host, is it possible to cross-install the policy store to the target rootfs image on the host?
> 
> Thank you very much!
> 
> Best regards,
> Harry
>  		 	   		  
> _________________________________________________________________
> 想知道明天天气如何？必应告诉你！
> http://cn.bing.com/search?q=%E5%A4%A9%E6%B0%94%E9%A2%84%E6%8A%A5&form=MICHJ2
You should be able to build the policy on a different maching and just
install it on the ARM box.

Also you can add these flags to /etc/selinux/semanage.conf

    * Enable configuration of bzip behavior from Stephen Smalley.
      bzip-blocksize=0 to disable compression and decompression support.
      bzip-blocksize=1..9 to set the blocksize for compression.
      bzip-small=true to reduce memory usage for decompression
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvyilkACgkQrlYvE4MpobMRogCeMIWdWC5XYKDWLM6mfeSD/aUC
Bt0AoIsnS4dWW/iLVe0vBV+QKY1OI86o
=5Y3x
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
