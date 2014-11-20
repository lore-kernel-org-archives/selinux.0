Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAKKiO3L012914
 for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2014 15:44:24 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so2461826qae.41
 for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2014 12:44:22 -0800 (PST)
Message-ID: <546E52A3.8050802@quarksecurity.com>
Date: Thu, 20 Nov 2014 15:44:19 -0500
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [RFC] systemd the userspace object manager
References: <546B760D.8070407@tresys.com>
 <20141118192010.GA32498@e145.network2> <546DF23A.2000300@tresys.com>
In-Reply-To: <546DF23A.2000300@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Christopher J. PeBenito wrote:
> On 11/18/2014 2:20 PM, Dominick Grift wrote:
>>> class init_service
>>> {
>>>      start
>>>      stop
>>>      status
>>> }
>>>
>> I cannot really substantiate but it look like these are also used to start/stop/get status of systemd (session) daemons, so i suppose start_init, stop_init, get_status_init
>>
>> I suspect this is mainly for starting the systemd session daemons. Logind uses these i believe.
>>
>> so to start a systemd session daemon: allow ARG init_t:init start_init;  or something maybe?
>
> Why would those daemons need to be treated specially?  In the end
> they're still services; they may have special system features, but in
> that case you don't allow just anyone to stop/start them.
>

I can see why you'd want someone to be able to restart apache but not 
everything. Certainly having specific permissions is not the way to 
accomplish that.

The rule above is kind of strange, permissions should not be equivalence 
classes, types should be, so it should be more like:

allow <domain requesting restart> <derived service label> : init {start 
stop}

right?
