Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5R8QVrT007255
	for <selinux@tycho.nsa.gov>; Sun, 27 Jun 2004 04:26:31 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5R8QH5h004357
	for <selinux@tycho.nsa.gov>; Sun, 27 Jun 2004 08:26:17 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 27 Jun 2004 08:25:29 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BeUOS-00049o-2s
	for selinux@tycho.nsa.gov; Sun, 27 Jun 2004 07:48:04 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BeUvW-00038I-MG
	for selinux@tycho.nsa.gov; Sun, 27 Jun 2004 08:22:14 +0000
Date: Sun, 27 Jun 2004 08:22:14 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: is there a way to express permission to access any tcp or udp socket?
Message-ID: <20040627082214.GC11890@lkcl.net>
References: <20040627080856.GB11890@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040627080856.GB11890@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

due to the terribly bad taste of replying to your own posts, i
had better phrase this as a question in need of confirmation:

	allow fireflier_t domain:{ tcp_socket udp_socket } { getattr };

is this right? :)

l.

On Sun, Jun 27, 2004 at 08:08:56AM +0000, Luke Kenneth Casson Leighton wrote:

> hi, i'm in the process of getting this fireflier policy right, and
> it (like lsof) reads /proc/NNNN/fd/N to obtain the name of the program
> that's actually using a tcp or udp socket - and then allowing the user
> the option of banning or allowing that program to send or receive
> tcp or udp traffic (on demand.  it's really cool).
> 
> of course, fireflier needs to do a stat of /proc/NNNN/fd/N in order
> to find out its inode - hence the getattr.
> 
> i've patched fireflierd to stop it doing a stat of EVVEERRYY single
> damn file descriptor (!!!) but there are still
> 
> i don't want to have to add permission for postfix_t, sendmail_t,
> exim_t, nntp_t, sshd_t, lpd_t, 
> every_single_server_i_can_think_of_and_all_those_that_i_can't_t:
> 
> 	allow fireflier_t rpcd_t:tcp_socket { getattr };
> 	allow fireflier_t rpcd_t:udp_socket { getattr };
> 	allow fireflier_t sshd_t:tcp_socket { getattr };
> 	allow fireflier_t user_t:udp_socket { getattr };
> 	allow fireflier_t user_t:tcp_socket { getattr };
> 
> does anyone know of a way to do something like, oh, this:
> 
> 	allow fireflier_t absolutely_everything_t:tcp_socket { getattr };
> 	allow fireflier_t absolutely_everything_t:udp_socket { getattr };
> 
> what should i put in the absolutely_everything_t?
> 
> much appreciated,
> 
> l.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
