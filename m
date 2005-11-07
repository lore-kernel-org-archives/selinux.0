Message-ID: <436F8383.9030909@cornell.edu>
Date: Mon, 07 Nov 2005 11:40:35 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
   Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, James Morris <jmorris@redhat.com>,
   Chad Sellers <csellers@tresys.com>
Subject: Re: [ SELINUX ] [ POLICYCOREUTILS ] Convert setsebool	-P	to	use	libsemanage
References: <436915FB.3040500@tresys.com>	 <1131027033.23420.30.camel@moss-spartans.epoch.ncsc.mil>	 <436A86E6.4040205@cornell.edu>  <436AF7BC.5000705@cornell.edu>	 <1131116390.23420.247.camel@moss-spartans.epoch.ncsc.mil>	 <436B8185.4050508@cornell.edu>	 <1131118424.23420.265.camel@moss-spartans.epoch.ncsc.mil>	 <436B8771.60203@redhat.com>	 <1131120757.23420.279.camel@moss-spartans.epoch.ncsc.mil>	 <1131121900.23420.288.camel@moss-spartans.epoch.ncsc.mil>	 <436BD878.1070300@cornell.edu>  <436BD9DB.2050700@cornell.edu> <1131371323.20591.16.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131371323.20591.16.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> No, the presence of libsemanage or even a particular version of
> libsemanage doesn't tell us whether the system policy is managed via
> libsemanage.  It only tells us that some code on the system is linked
> against libsemanage.  Conversion of a system to being managed via
> libsemanage is a change in the policy package, not a change in
> libsemanage.  In particular, it involves converting the policy package
> to using policy modules and using semodule.
>   
Does the existance of some random file in /etc/selinux/?/modules/active 
imply that libsemanage is managing the system. Shouldn't we be looking 
at /etc/selinux/config instead?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
