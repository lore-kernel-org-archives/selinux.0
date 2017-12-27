Message-ID: <1514391741.2780.4.camel@btinternet.com>
From: Richard Haines <richard_c_haines@btinternet.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Casey Schaufler
 <casey@schaufler-ca.com>, paul@paul-moore.com
Cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, vyasevich@gmail.com,
 nhorman@tuxdriver.com, sds@tycho.nsa.gov, eparis@parisplace.org
Date: Wed, 27 Dec 2017 16:22:21 +0000
In-Reply-To: <20171222174510.GB6123@localhost.localdomain>
References: <cover.1513940757.git.marcelo.leitner@gmail.com>
 <80e6a4fb06ec6b8f81577abd11827d75dd6689ce.1513940757.git.marcelo.leitner@gmail.com>
 <50a04eaf-6130-74d0-43e4-b09bd4de2180@schaufler-ca.com>
 <20171222174510.GB6123@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v3 1/4] security: Add support for SCTP security
 hooks
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-12-22 at 15:45 -0200, Marcelo Ricardo Leitner wrote:
> On Fri, Dec 22, 2017 at 09:20:45AM -0800, Casey Schaufler wrote:
> > On 12/22/2017 5:05 AM, Marcelo Ricardo Leitner wrote:
> > > From: Richard Haines <richard_c_haines@btinternet.com>
> > > 
> > > The SCTP security hooks are explained in:
> > > Documentation/security/LSM-sctp.rst
> 
> Thanks Casey for your comments. However, I'm not that acquainted with
> these area of codes and I cannot work on them. I'll just wait for
> Richard then.

I'm back online and will post a V4 set of patches within a week. These
will address Paul's comments as per [1] and Casey's regarding the
documentation.
Sorry for the delay


[1] https://marc.info/?l=selinux&m=151274018809822&w=2

> 
>   Marcelo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sctp" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
