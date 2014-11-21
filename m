Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sALCi2fQ029998
 for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2014 07:44:03 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so4129933qcw.9
 for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2014 04:44:01 -0800 (PST)
Received: from strange.home (pool-96-244-82-214.bltmmd.fios.verizon.net.
 [96.244.82.214])
 by mx.google.com with ESMTPSA id s2sm4555708qan.29.2014.11.21.04.43.59
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Fri, 21 Nov 2014 04:44:00 -0800 (PST)
Message-ID: <546F338D.9030003@quarksecurity.com>
Date: Fri, 21 Nov 2014 07:43:57 -0500
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [RFC] systemd the userspace object manager
References: <546B760D.8070407@tresys.com>
 <20141118192010.GA32498@e145.network2> <546DF23A.2000300@tresys.com>
 <546E52A3.8050802@quarksecurity.com> <20141121113120.GA25417@e145.network2>
In-Reply-To: <20141121113120.GA25417@e145.network2>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Dominick Grift wrote:
> On Thu, Nov 20, 2014 at 03:44:19PM -0500, Joshua Brindle wrote:
>> I can see why you'd want someone to be able to restart apache but not
>> everything. Certainly having specific permissions is not the way to
>> accomplish that.
>>
>> The rule above is kind of strange, permissions should not be equivalence
>> classes, types should be, so it should be more like:
>>
>> allow<domain requesting restart>  <derived service label>  : init {start
>> stop}
>>
>> right?
>
> If only it were that simple. Here is my take on the whole thing:
>
> Generally services are managed by "service" access checks on unit file types
>
> allow webadmin webserverunitfile:service {start stop};
>
> However these is also a concept of transient (in-memory) unit files, managing a service through a transient unit would work like:
>
> allow user self:service {start stop};
>
> or in the case of transient systemd units:
>
> allow user systemd:service {stop start};
>
> Then there is the system(d) class which also has the start, stop permissions associated with it (it is yet to be determined for what exactly)
>
> In my policy systemd-logind does the following:
>
> allow logind_t systemd:system(d) { start stop };
>
> I suspect that this is required to spawn the systemd session daemon (at least)
> It may or may not also be required for kexec (not sure as i havent tested that yet)
>
> This is pretty much just all speculation though, in the sense that this is broadly what i see happening in the system, and it might not be the same as what *should* be happening
> Instead its probably better to just read the systemd object manager code
>

I don't think we are saying different things. Note my rule above 
specifically says the object label is derived. I never speculated about 
how it would be derived, though it could be based on label mapping or 
type_trans calculations. In the cases above it would seem like there are 
some transient labels that need to be derived without the luxury of an 
object on-disk so you could either using a labeling file:

user_u:user_r:user_t:s0		user_u:user_r:user_service_t:s0

or a type_transition using the systemd or service object class:

type_transition user_t systemd_t service:user_service_t

Both of these has been done for various other userspace object classes, 
I haven't yet seen anything that makes systemd 'special'.
