Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v222IJj9030806
 for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2017 21:18:19 -0500
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Re: Securing a service written in Python
Date: Thu, 2 Mar 2017 13:18:14 +1100
References: <549fe2cd-80db-44ee-a34e-edaa38550a3f@gmail.com>
In-Reply-To: <549fe2cd-80db-44ee-a34e-edaa38550a3f@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201703021318.14794.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2 Mar 2017 11:03:15 AM Ian Pilcher wrote:
> Can anyone provide any pointers, links, advice, examples, etc. for
> writing a policy to secure a service written in Python?

Why would it be any different to services written in Perl and other interpreted 
languages?

Mailman is written in Python and works well for me on SE Linux systems.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
