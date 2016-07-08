Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u683PKgV006116
 for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2016 23:25:20 -0400
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: If autorelabel, force permissive mode.
Date: Fri, 8 Jul 2016 13:24:46 +1000
References: <1467798202-6412-1-git-send-email-rjones@redhat.com>
 <20160707135017.GA23053@meriadoc.perfinion.com>
 <20160707205614.GA26165@redhat.com>
In-Reply-To: <20160707205614.GA26165@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201607081324.46839.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Fri, 8 Jul 2016 06:56:14 AM Richard W.M. Jones wrote:
> On Thu, Jul 07, 2016 at 09:50:17PM +0800, Jason Zaman wrote:
> > Doesn't Android set the labels on the /system disk image during build?
> > Maybe virt-builder can copy that? This would also speed up initial
> > deployment of new images.
> 
> Well this is the real problem.  Because the guest policy is a binary
> blob, and because the binary blobs are not (necessarily) compatible
> across kernel versions, we cannot just load the policy blob of the
> guest into our kernel, so we cannot label guests properly.  Sure be
> nice if policy wasn't stored in this way.

While virt-builder is one case that needs special attention the important fact 
is that autorelabel has never worked as well as it should have.  There has 
never been a guarantee that an autorelabel operation would complete 
successfully in the face of the wrong combination of mislabeled files.  It 
might be a good idea to copy the Android build process to virt-builder for 
other reasons but even so the design Richard proposes is worth having 
regardless.

Also the way that the reboot was managed was never that great, especially on a 
systemd system.  I can't recall how much of that is my responsibility.

I'd like to get this in Debian.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
