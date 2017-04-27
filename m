Date: Thu, 27 Apr 2017 11:08:32 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Sebastien Buisson <sbuisson.ddn@gmail.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, Sebastien Buisson <sbuisson@ddn.com>,
 james.l.morris@oracle.com
Subject: Re: [PATCH 3/3] selinux: expose policy SHA256 checksum via selinuxfs
In-Reply-To: <1493231502.32540.12.camel@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.20.1704271107450.28011@namei.org>
References: <1493218936-18522-1-git-send-email-sbuisson@ddn.com>
 <1493218936-18522-3-git-send-email-sbuisson@ddn.com>
 <1493231502.32540.12.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 26 Apr 2017, Stephen Smalley wrote:

> > +	return simple_read_from_buffer(buf, count, ppos, tmpbuf,
> > length);
> > +}
> 
> Should we also include information about the hash used, in case it
> changes in the future?
> 

Good idea, yes.


-- 
James Morris
<jmorris@namei.org>
