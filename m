Sender: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Thu, 11 Jun 2015 17:22:02 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] Only invoke RPM on RPM-enabled Linux distributions
Message-ID: <20150611152202.GA13058@siphos.be>
References: <20150609112624.GA10618@siphos.be> <5576D9CC.3020102@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5576D9CC.3020102@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jun 09, 2015 at 08:19:24AM -0400, Stephen Smalley wrote:
> On 06/09/2015 07:26 AM, Sven Vermeulen wrote:
> > In this patch, we use the Python platform module to get the Linux
> > distribution, and only start the RPM-related activities on Linux
> > distributions that use RPM as their native package manager.
> > 
> > Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
> 
> Is there a more general way that we could do this without hardcoding
> checks of distribution names?  Maybe we could just test for the
> existence of rpm?

That wouldn't be sufficient.

The rpm binary might be installed for other reasons. The code in sepolicy is
used to query the rpm database and search for specific package names. This
is distribution-specific behavior.

If you rather check on the rpm binary, then additional checks will need to
be added to make sure that the assumptions that the code takes (such as
"selinux-policy" package being available) are valid as well.

Wkr,
        Sven Vermeulen
