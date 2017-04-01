Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v31EaHFc016650
 for <selinux@tycho.nsa.gov>; Sat, 1 Apr 2017 10:36:17 -0400
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Re: ssh/cron access checks and my Play Machine
Date: Sun, 2 Apr 2017 01:36:10 +1100
References: <201704012359.15451.russell@coker.com.au>
 <20170401142541.GA32568@t450.enp8s0.d30>
In-Reply-To: <20170401142541.GA32568@t450.enp8s0.d30>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201704020136.10983.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, 2 Apr 2017 01:25:41 AM Dominick Grift wrote:
> So youre saying the a policy upgrade changed the permissions of
> ~/.ssh/authorized_keys from 0600 to ???? how is that possible? Also is ~

No, a policy upgrade and relabel.

> not set to 0700? User wouldnt be able to traverse to other uids' ~/.ssh

Unless they have the same UID, which is the point of a Play Machine.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
