Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7UKPcB8011789
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 16:25:38 -0400
Received: from [10.255.0.12] (unknown [10.255.0.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "Paul Bolton", Issuer "M0NOC" (verified OK))
 by tbhext01.m0noc.net (Postfix) with ESMTPSA id 3sP0Q76svgz2ZYPs
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 21:25:35 +0100 (BST)
Subject: Re: SELinux MLS Policies
To: selinux@tycho.nsa.gov
References: <01e601d202e0$7aaf62d0$700e2870$@a.bolton@m0noc.net>
 <20160830192617.3jwikiwshwish3c3@rhel-at-redhat.localdomain>
From: Paul Bolton <paul.a.bolton@m0noc.net>
Message-ID: <89b246bc-42c1-d568-9e2a-b3d602d2bf50@m0noc.net>
Date: Tue, 30 Aug 2016 21:25:33 +0100
MIME-Version: 1.0
In-Reply-To: <20160830192617.3jwikiwshwish3c3@rhel-at-redhat.localdomain>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 30/08/16 20:26, Petr Lautrbach wrote:
> 
> On RHEL and CentOS should sufficient to:
> 
> 1. install selinux-policy-mls package
> 2. set SELinux to permissive and mls type
> 3. run fixfiles -F onboot
> 4. reboot
> 5. if everything went fine and the filesystem is correctly relabeled,
> switch back to enforcing
> 
> and if you want to login as root using ssh, you need to turn
> ssh_sysadm_login boolean on
> 

Thanks for the suggestion. Unfortunately that is pretty much what I
originally did, which is why I thought I'll give the reference policy a
go since getting the source is easier.

The main difference with the original vendor setup was that I touched
/.autorelabel rather than run fixfiles (which I think does the same
thing). Result is that at (5) cannot log in as root, normal or staff_u
on the console, normal user or a staff_u user over the net. I don't want
to allow root over the net.

I've just retested as you have mentioned and the same results.

I'll have another look at the vendor supplied mls setup tomorrow (this
one didn't have the /dev/log issue), but does have other AVC's listed.

So, looks like I have two challenges-
a. figure out why the vendor setup doesn't appear to work, and
b. understand the /dev/log. etc changes from reference policy to vendor
policy.

-- 
Paul
----
http://blog.m0noc.com/ | https://keybase.io/m0noc
4329 E4C5 71F3 58B2 2246  D04D 25DA 39C2 3876 FE3D
