Subject: Re: security_bounded_transition fails
To: Hannu Savolainen <hannu.savolainen@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@huawei.com>, selinux@tycho.nsa.gov
References: <B295455A1EDEE541907F53334176EF68070002FE@lhreml504-mbx>
 <20151218084603.GA26456@x250> <20151218102056.GB26456@x250>
 <20151218104500.GC26456@x250>
 <B295455A1EDEE541907F53334176EF68070003D0@lhreml504-mbx>
 <20151218150500.GE26456@x250>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56745639.3020206@tycho.nsa.gov>
Date: Fri, 18 Dec 2015 13:53:45 -0500
MIME-Version: 1.0
In-Reply-To: <20151218150500.GE26456@x250>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/18/2015 10:05 AM, Dominick Grift wrote:
> On Fri, Dec 18, 2015 at 11:27:13AM +0000, Hannu Savolainen wrote:
>> Many thanks,
>
>> Adding the allow rules seem to be enough (have to verify that one more time next week). Fortunately the typebounds rule doesn't seem to be necessary since it triggered avalanche of dependency problems everywhere.
>
>> Best regards,
>
>> Hannu
>
> Cc: selinux list
>
> I suspect though that you eventually really need to add the typebounds
> statement.

typebounds is required for a multi-threaded process to setcon().

And note that setcon() only changes the context of the current thread, 
not all threads in the process.
