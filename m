Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3R7lBcm023633
	for <selinux@tycho.nsa.gov>; Sat, 27 Apr 2013 03:47:11 -0400
Received: by mail-wi0-f170.google.com with SMTP id l13so1464719wie.5
        for <selinux@tycho.nsa.gov>; Sat, 27 Apr 2013 00:47:09 -0700 (PDT)
Date: Sat, 27 Apr 2013 09:46:28 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Joshua Brindle <brindle@quarksecurity.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: [Ann] SELinux userspace release
Message-ID: <20130427074628.GA23204@siphos.be>
References: <CADjGSjhkWnxg6rEzUowJ4pU0icFYbboxeDh2ejZ6gpg83W0QYA@mail.gmail.com>
 <20130425200130.GA17297@siphos.be>
 <CADjGSjipXROGK+9_bpJZngjBF7rH-=U3nUpwyUdgA_UERbn=Vg@mail.gmail.com>
 <CAPzO=NyzomgTJoSvf9Ogxae2BDfWk=UFiu6C7qobNcMfDc7kgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAPzO=NyzomgTJoSvf9Ogxae2BDfWk=UFiu6C7qobNcMfDc7kgw@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 26, 2013 at 08:36:05AM +0200, Sven Vermeulen wrote:
> > semanage permissive builds a module to make a permissive domain. On
> > Fedora there is an out-of-tree policy build environment in
> > /usr/share/selinux. Without this environment it can't build a module.
> > Does Gentoo have it in a different place or just not at all?
> 
> In the previous release it worked so I probably need to find where the
> location is coded and have that point to
> /usr/share/selinux/$SELINUXTYPE/include/Makefile or so. That is the
> Makefile used to build (refpolicy-style) policy modules here.

I've been able to get this to work by creating a /etc/selinux/sepolgen.conf
file that contains the following:

SELINUX_DEVEL_PATH=/usr/share/selinux/strict/include


> > > https://bugs.gentoo.org/show_bug.cgi?id=467268
> > >
> > > - policycoreutils' sepolicy command requires yum python bindings
> > >
> > > Since yum is not available on Gentoo, is this really necessary?
> > >
> >
> > Unfortunate. I'd exclude it for now and hopefully we can work out
> > making it more distro independent.
> 
> Certainly. I'll see if I can draft up something when I get more familiar
> with the required functionalities.

Well, I removed the yum dependency and the __extract_rpms method (+ the
call towards it). But trying to use sepolicy still gives me stacktraces that
I am having difficulties with to debug:

~$ sepolicy communicate -s portage_t 
Traceback (most recent call last):
  File "/usr/bin/sepolicy-2.7", line 464, in <module>
    args = parser.parse_args()
  File "/usr/lib64/python2.7/argparse.py", line 1688, in parse_args
    args, argv = self.parse_known_args(args, namespace)
  File "/usr/lib64/python2.7/argparse.py", line 1720, in parse_known_args
    namespace, args = self._parse_known_args(args, namespace)
  File "/usr/lib64/python2.7/argparse.py", line 1908, in _parse_known_args
    positionals_end_index = consume_positionals(start_index)
  File "/usr/lib64/python2.7/argparse.py", line 1885, in consume_positionals
    take_action(action, args)
  File "/usr/lib64/python2.7/argparse.py", line 1794, in take_action
    action(self, namespace, argument_values, option_string)
  File "/usr/lib64/python2.7/argparse.py", line 1090, in __call__
    namespace, arg_strings = parser.parse_known_args(arg_strings, namespace)
  File "/usr/lib64/python2.7/argparse.py", line 1720, in parse_known_args
    namespace, args = self._parse_known_args(args, namespace)
  File "/usr/lib64/python2.7/argparse.py", line 1926, in _parse_known_args
    start_index = consume_optional(start_index)
  File "/usr/lib64/python2.7/argparse.py", line 1866, in consume_optional
    take_action(action, args, option_string)
  File "/usr/lib64/python2.7/argparse.py", line 1794, in take_action
    action(self, namespace, argument_values, option_string)
  File "/usr/bin/sepolicy-2.7", line 63, in __call__
    from sepolicy.network import domains
  File "/usr/lib64/python2.7/site-packages/sepolicy/network.py", line 44, in <module>
    portrecs, portrecsbynum = _gen_port_dict()
  File "/usr/lib64/python2.7/site-packages/sepolicy/network.py", line 31, in _gen_port_dict
    for i in info(sepolicy.PORT):
  File "/usr/lib64/python2.7/site-packages/sepolicy/__init__.py", line 182, in info
    dict_list = _policy.info(setype, name)
RuntimeError: No such file or directory

Any idea what this could be about?

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
