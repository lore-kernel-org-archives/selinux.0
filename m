Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vBFE2DwE003292
 for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2017 09:02:13 -0500
Received: by mail-it0-f65.google.com with SMTP id p139so19820431itb.1
 for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2017 06:02:09 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
CC: Richard Haines <richard_c_haines@btinternet.com>, <selinux@tycho.nsa.gov>,
 <netdev@vger.kernel.org>, <linux-sctp@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>,
 Vlad Yasevich <vyasevich@gmail.com>, <nhorman@tuxdriver.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Date: Fri, 15 Dec 2017 09:02:04 -0500
Message-ID: <1605a7b2cb0.280e.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <20171214210422.GQ3532@localhost.localdomain>
References: <20171127193121.2666-1-richard_c_haines@btinternet.com>
 <20171212160800.GE3532@localhost.localdomain>
 <CAHC9VhR+WoO3UtdXLp+9mQ=c=avpEQ5-W8vTkEWfxXH1EkUS8A@mail.gmail.com>
 <20171212215638.GH3532@localhost.localdomain>
 <CAHC9VhQ5iQsXum6NVkL-qdzu=bxVcaOscPjTSVufLzRbW_1_Pw@mail.gmail.com>
 <20171214210422.GQ3532@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [PATCH 2/4] sctp: Add ip option support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On December 14, 2017 4:04:28 PM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:

> On Tue, Dec 12, 2017 at 05:24:46PM -0500, Paul Moore wrote:
>> On Tue, Dec 12, 2017 at 4:56 PM, Marcelo Ricardo Leitner
>> <marcelo.leitner@gmail.com> wrote:
>> > On Tue, Dec 12, 2017 at 04:33:03PM -0500, Paul Moore wrote:
>> >> On Tue, Dec 12, 2017 at 11:08 AM, Marcelo Ricardo Leitner
>> >> <marcelo.leitner@gmail.com> wrote:
>> >> > Hi Richard,
>> >> >
>> >> > On Mon, Nov 27, 2017 at 07:31:21PM +0000, Richard Haines wrote:
>> >> > ...
>> >> >> --- a/net/sctp/socket.c
>> >> >> +++ b/net/sctp/socket.c
>> >> >> @@ -3123,8 +3123,10 @@ static int sctp_setsockopt_maxseg(struct sock
>> *sk, char __user *optval, unsigned
>> >> >>
>> >> >>       if (asoc) {
>> >> >>               if (val == 0) {
>> >> >> +                     struct sctp_af *af = sp->pf->af;
>> >> >>                       val = asoc->pathmtu;
>> >> >> -                     val -= sp->pf->af->net_header_len;
>> >> >> +                     val -= af->ip_options_len(asoc->base.sk);
>> >> >> +                     val -= af->net_header_len;
>> >> >>                       val -= sizeof(struct sctphdr) +
>> >> >>                                       sizeof(struct sctp_data_chunk);
>> >> >>               }
>> >> >
>> >> > Right below here there is a call to sctp_frag_point(). That function
>> >> > also needs this tweak.
>> >> >
>> >> > Yes, we should simplify all these calculations. I have a patch to use
>> >> > sctp_frag_point on where it is currently recalculating it on
>> >> > sctp_datamsg_from_user(), but probably should include other places as
>> >> > well.
>> >>
>> >> FYI: Richard let me know he is occupied with another project at the
>> >> moment and likely won't be able to do another respin until next week
>> >> at the earliest.
>> >
>> > Okay, thanks. I can do a follow-up patch if it helps.
>>
>> I'll leave that up to you, I think your comments are pretty
>> straightforward and should be easy for Richard to incorporate, and
>> there is a lot to be said for including the fix in the original patch,
>> but if you would prefer to send a separate patch I think that's fine
>> too.
>
> This patchset conflicts with the stream schedulers patchset (on
> sctp.h) and will also conflict with the stream interleaving patchsets
> from Xin (other files).
>
> I rebased the patchset upon current crypto tree but the last patchset
> on stream interleaving is still to be accepted via net-next.
>
> I'm unsure on how to proceed here. Please advise.
>
> Thanks,
> Marcelo

I still believe the right course of action is to merge this via the SELinux
tree (based on Linus' tree). Due to the nature of SELinux we often have to
deal with conflicts like this; I haven't seen the conflicts your talking
about (I'm currently traveling with limited access) but Linus should be
able to handle the trivial fixes, if it is more complex we can provide
guidance about how to resolve it.

--
paul moore
www.paul-moore.com
