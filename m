Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8DMA8Ns028988
	for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2005 18:10:08 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8DM7BdV027001
	for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2005 22:07:11 GMT
Subject: Re: error building file_contexts
From: Eric Paris <eparis@parisplace.org>
To: antoine <antoine@nagafix.co.uk>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1126647898.3769.19.camel@localhost>
References: <1126563533.13869.5.camel@localhost>
	 <1126617433.29303.25.camel@moss-spartans.epoch.ncsc.mil>
	 <1126618085.4218.14.camel@localhost.localdomain>
	 <1126623363.6074.7.camel@localhost.localdomain>
	 <1126647898.3769.19.camel@localhost>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 18:07:13 -0400
Message-Id: <1126649233.6074.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> (...)
> -/home/rsyslog
> -/emul/lib(64)?/*$
> -/home/rsyslog
> -/emul/lib(64)?/.*\.so(\.[^/]*)*/*$
> -/home/rsyslog
> -/emul/lib(64)?/ld-[^/]*\.so(\.[^/]*)*/*$
> -/home/rsyslog
> -/usr/sbin/amavisd(.*)?/*$
> -/home/rsyslog
> Traceback (most recent call last):
>   File "/usr/sbin/genhomedircon", line 475, in ?
>     oldgenhomedircon(cmds[0], cmds[1])
>   File "/usr/sbin/genhomedircon", line 190, in oldgenhomedircon
>     if re.search(regex, potential, 0):
>   File "/usr/lib/python2.3/sre.py", line 137, in search
>     return _compile(pattern, flags).search(string)
>   File "/usr/lib/python2.3/sre.py", line 230, in _compile
>     raise error, v # invalid expression
> sre_constants.error: nothing to repeat
> make: *** [file_contexts/file_contexts] Error 1
> 
> Any ideas?
> 
> Thanks
> Antoine
> 
> 
> For reference, here is the updated code snippet:
> (...)
> 	for potential in potential_prefixes.keys():
>                 addme = 1
>                 for regex in prefix_regex:
>                         #match a trailing (/*)? which is actually a bug
> in rpc_pipefs
>                         regex = re.sub("\(/\*\)\?$", "", regex)
>                         #match a trailing .+
>                         regex = re.sub("\.+$", "", regex)
>                         #match a trailing .*
>                         regex = re.sub("\.\*$", "", regex)
>                         #strip a (/.*)? which matches anything trailing
> to a /*$ which matches trailing /'s
>                         regex = re.sub("\(\/\.\*\)\?", "", regex)
>                         regex = regex + "/*$"
>                         sys.stderr.write("-%s\n" % regex)
>                         sys.stderr.write("-%s\n" % potential)
>                         sys.stderr.flush()
>                         if re.search(regex, potential, 0):
>                                 addme = 0
> 
>                 if addme == 1:
>                         if not prefixes.has_key(potential):
>                                 prefixes[potential] = ""
> (...)


So I simplified the problem.  Maybe someone with more regex or python
foo can help us out.  Python refuses to use (.*)? as a valid regular
expression.  Seems like we want to say match anything 0 or more times.
Why is this invalid and what would be valid?

>>> import re
>>> test = re.sub("(.*)?", "", "hello")
Traceback (most recent call last):
  File "<stdin>", line 1, in ?
  File "/usr/lib/python2.3/sre.py", line 143, in sub
    return _compile(pattern, 0).sub(repl, string, count)
  File "/usr/lib/python2.3/sre.py", line 230, in _compile
    raise error, v # invalid expression
sre_constants.error: nothing to repeat



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
