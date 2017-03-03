Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v23FiLpL007348
 for <selinux@tycho.nsa.gov>; Fri, 3 Mar 2017 10:44:22 -0500
Received: by mail-ot0-f193.google.com with SMTP id a12so8808841ota.2
 for <selinux@tycho.nsa.gov>; Fri, 03 Mar 2017 07:44:20 -0800 (PST)
Subject: Re: [systemd-devel] SELinux type transition rule not working
To: Simon Sekidde <ssekidde@redhat.com>
References: <51816900-3b52-8eb6-bf86-75aa8540fca3@gmail.com>
 <20170301222511.GA29059@gardel-login>
 <944362898.27340550.1488467628547.JavaMail.zimbra@redhat.com>
Cc: Systemd <systemd-devel@lists.freedesktop.org>, selinux@tycho.nsa.gov,
 lennart@poettering.net
From: Ian Pilcher <arequipeno@gmail.com>
Message-ID: <3cf89bd9-7f2b-81d0-c531-db6890cc2fee@gmail.com>
Date: Fri, 3 Mar 2017 09:44:18 -0600
MIME-Version: 1.0
In-Reply-To: <944362898.27340550.1488467628547.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/02/2017 09:13 AM, Simon Sekidde wrote:
> I assume this would be a pid file?

You assume correctly.

> If so then what you are probably looking for is a filename_trans rule
> and will require a new interface in squid.if for this.
>
> Try something like
>
> interface(`squid_filetrans_named_content',` gen_require(`
> type_squid_var_run_t; ')
>
> files_pid_filetrans($1, squid_var_run_t, dir, "squozy") ')

Not sure where squid came from.  The service is one of my own making
called "squoxy" (short for "Squeezebox proxy").  Its purpose is to
forward Squeezebox discovery broadcast packets from one network to
another.

So I assume that I would need to add something like this to my policy
module:

   files_pid_filetrans(var_run_t, squoxy_var_run_t, dir, "squoxy")

(I'm guessing at what to put in for $1.)

>> Hmm, so the relevant code in systemd actually labels the dir after
>> creating it after an selinux database lookup, so from our side all
>> should be good:
>>
>> https://github.com/systemd/systemd/blob/master/src/core/execute.c#L1857
>>
>>
>>(specifically, we all mkdir_p_label() instead of plain mkdir_p()
 >> there)

And this is working now, presumably after a reboot?  I do so love
non-deterministic computers.  :-/

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
