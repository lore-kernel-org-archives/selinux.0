Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r54F4POE006083
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2013 11:04:25 -0400
Received: by mail-ob0-f171.google.com with SMTP id dn14so559839obc.30
        for <selinux@tycho.nsa.gov>; Tue, 04 Jun 2013 08:04:25 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 4 Jun 2013 18:04:25 +0300
Message-ID: <CAGXs5wVBc3k_o9esDhB+fvfxLQ=U8JskzzhuYLxD6d_3Hf=gug@mail.gmail.com>
Subject: xt_SECMARK and "unable to map security context 'httpcontext'" error
From: Kevin Wilson <wkevils@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
I tried this:

modprobe xt_SECMARK
iptables -t mangle -A PREROUTING -p tcp --dport 80 -j SECMARK --selctx
httpcontext
and got:
iptables: No chain/target/match by that name.


Kernel log says:
localhost kernel: [  491.321048] xt_SECMARK: unable to
map security context 'httpcontext'

Any ideas what should I do to enable this rule?

regards,
Kevin

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
