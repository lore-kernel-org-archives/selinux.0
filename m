Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tADFePr6010076
 for <selinux@tycho.nsa.gov>; Fri, 13 Nov 2015 10:40:25 -0500
Subject: Re: CIL: question with regard to CIL ioctl filtering support and
 neverallow
To: <selinux@tycho.nsa.gov>
References: <20151113152830.GA21890@x250>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <56460452.3090503@tresys.com>
Date: Fri, 13 Nov 2015 10:40:02 -0500
MIME-Version: 1.0
In-Reply-To: <20151113152830.GA21890@x250>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/13/2015 10:28 AM, Dominick Grift wrote:
> 
> This commit added iotctl whitelisting support to CIL:
> https://github.com/SELinuxProject/selinux/commit/ef93dfe0393c4a60483c3f7729dd98a2f886606a
> 
> then later CIL whitelisting was extended with neverallow support here:
> https://github.com/SELinuxProject/selinux/commit/99fc177b5af4e1e8855d42d2d01cb93ac7f9d14b
> 
> would the CIL ioctl whitelisting support have to be extended with the
> ioctl whitelisting neverallow support as well?

Yes, that is something we are working on. It should be upstreamed
sometime in the next couple of weeks.

- Steve
