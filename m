Message-ID: <1513626772.2675.4.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Arnold, Paul C CTR USARMY PEO STRI (US)" <paul.c.arnold4.ctr@mail.mil>,
 SELinux =?UTF-8?Q?=E2=80=8E=5Bselinux=40tycho=2Ensa=2Egov=5D=E2=80=8E?=
 <selinux@tycho.nsa.gov>
Date: Mon, 18 Dec 2017 14:52:52 -0500
In-Reply-To: <7322D64AC622D441BC921DE15D30CD21A2082E61@UGUNHPAFH.easf.csd.disa.mil>
References: <7322D64AC622D441BC921DE15D30CD21A2082E61@UGUNHPAFH.easf.csd.disa.mil>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Object range_transition issue when type_transition is involved
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-12-18 at 17:36 +0000, Arnold, Paul C CTR USARMY PEO STRI
(US) wrote:
> All,
>  
> I am experiencing some issues using range_transition on objects when
> type_transition is also involved on the object.  Specifically, a
> range_transition rule on a target object with a "final" type (e.g. a
> type which went through a type_transition) does not seem to perform
> the range transition.
>  
>  
> For example, using a private var log type (uses a type_transition
> from var_log_t) does not perform the range transition:
>  
> range_transition mydomain_t mypriv_var_log_t:file mySystemHigh;
>  
>  
> I am confident my source domain is correct, I believe the issue is
> with the target object.  Policy version is 24.

Sorry, are you saying that mydomain_t is creating a file in /var/log,
and that you both want the file type to be set to mypriv_var_log_t and
the level set to mySystemHigh?

If so, then I believe the correct incantation would be:
type_transition mydomain_t var_log_t:file mypriv_var_log_t;
range_transition mydomain_t var_log_t:file mySystemHigh;
(obviously you might instead be using refpolicy macros/interfaces to
achieve the same end)

In both cases, the source type corresponds to the creating process, the
target type corresponds to the parent directory type, and the new type
or level is applied to new files.
