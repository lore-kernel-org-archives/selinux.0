Message-ID: <1504790447.22845.12.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Date: Thu, 07 Sep 2017 09:20:47 -0400
In-Reply-To: <20170907122642.GB1813@julius.enp8s0.d30>
References: <20170907122642.GB1813@julius.enp8s0.d30>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: conditional role and range transitions?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-09-07 at 14:26 +0200, Dominick Grift wrote:
> I was just reminded of the fact that role and range transitions
> cannot be conditional in kernel policy.
> 
> Is this technically impossible? Why can type transitions be
> conditional in kernel policy but not role and range transitions?

It isn't a fundamental restriction, but the conditional policy
implementation was done entirely in terms of TE policy due to its
original use case and only (conditional) avtab entries can currently be
enabled/disabled based on boolean states.  So it should be possible to
implement conditional policy support for other kinds of transitions,
but not trivial.
