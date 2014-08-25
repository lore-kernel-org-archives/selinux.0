Message-ID: <53FB49D4.8050802@tycho.nsa.gov>
Date: Mon, 25 Aug 2014 10:36:04 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>, "Stepan G. Fedorov" <stfedorov@gmail.com>
Subject: Re: semanage interface has no effect
References: <53FB19C7.1040500@gmail.com> <53FB35D2.3030307@tycho.nsa.gov>
 <53FB4192.8090203@gmail.com>
 <CAHC9VhSwgERb2NoY8vK3nT=wxBh7fyaD7ECGoxcRij5P6u1XKQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSwgERb2NoY8vK3nT=wxBh7fyaD7ECGoxcRij5P6u1XKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/25/2014 10:30 AM, Paul Moore wrote:
> On Mon, Aug 25, 2014 at 10:00 AM, Stepan G. Fedorov <stfedorov@gmail.com> wrote:
>> 25.08.2014 17:10, Stephen Smalley пишет:
>>
>>> Legacy network checks are gone; use peer labeling or secmark instead,
>>> http://paulmoore.livejournal.com/tag/documentation
>>
>>
>> Thank you for quick reply!
>>
>> In case of "just installed" system, where no iptables SECMARK rules present,
>> and no labeled packets arrive on network interface - what will be selinux
>> contexts of all incoming packets?
> 
> In this case the incoming packets would be labeled "unlabeled_t", just
> like any other unlabeled data on the system.

...but the new network permission checks will not be applied
until/unless you configure secmark or labeled networking.  Or set the
always_check_network policy capability to 1 for secmark, if your kernel
supports that.
