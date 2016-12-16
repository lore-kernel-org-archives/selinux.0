Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBGDVpLU025001
 for <selinux@tycho.nsa.gov>; Fri, 16 Dec 2016 08:31:51 -0500
Message-ID: <1481895113.5152.5.camel@btinternet.com>
Subject: Re: [RFC PATCH 1/1] kernel: Add SELinux SCTP protocol support
From: Richard Haines <richard_c_haines@btinternet.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@tycho.nsa.gov, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org
Date: Fri, 16 Dec 2016 13:31:53 +0000
In-Reply-To: <78b647ff-2c25-8207-f1cc-4c13dbed53fd@schaufler-ca.com>
References: <20161214133959.3078-1-richard_c_haines@btinternet.com>
 <78b647ff-2c25-8207-f1cc-4c13dbed53fd@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2016-12-14 at 09:02 -0800, Casey Schaufler wrote:
> On 12/14/2016 5:39 AM, Richard Haines wrote:
> > Add SELinux support for the SCTP protocol. The SELinux-sctp.txt
> > document
> > describes how the patch has been implemented with an example policy
> > and
> > tests using lkstcp-tools.
> 
> Please separate the LSM support from the SELinux support
> into patches 1/2 and 2/2 respectively. The documentation
> needs to be separated along the same lines as well. While
> I am only mildly concerned about the SELinux implementation
> I am very concerned about the LSM side.
> 
> 
Thanks for your comments. I do not see a problem with
resolving them all in the next RFC patch.
