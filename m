Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carsten.grohmann@raumbildsysteme.de>
To: Wayne Salamon <wsalamon@tislabs.com>
Subject: Re: Core policy, second pass
Date: Thu, 27 Feb 2003 09:23:25 +0100
References: <Pine.LNX.4.33.0302261350580.3945-200000@vox.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0302261350580.3945-200000@vox.gw.tislabs.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <200302270923.25751.carsten.grohmann@raumbildsysteme.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Mittwoch, 26. Februar 2003 19:57 schrieb Wayne Salamon:
> Well, we need some consensus. Who is the typical user of the SELinux
> download, and what are their requirements? Or, do we require some
> customization for the user to be able to run, to enable base
> functionality?

I think the idea of Leslie J. French with a really core policy based 
only of the "CPU+DISK" (incl. ssh) rules, is a good way. The other 
rules for net, gpg and others should be optional and only includes by 
admins wish.
Thru this we will have no problems with strip down the policy. We will 
have a little base set. It will be simple to maintain also. 
All others rules could be include manually or e.g. vie "make 
workstation".
In pratice we could use a rules directory and different target 
directorys (base, network, mail, user, x, ..) and link the rules to 
each necessary destination. A makefile could generate the policy only 
from the target directory.

Carsten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
