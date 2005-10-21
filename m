Message-ID: <4359199A.40303@cornell.edu>
Date: Fri, 21 Oct 2005 12:38:50 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [ SEPOL ] Further users cleanup
References: <435903C2.2050805@cornell.edu> <1129908379.27663.59.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129908379.27663.59.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Ok.  Note that we'll likely want to remove all wildcards from the map
> files (for both libsepol and libsemanage) and explicitly list all
> interfaces we want exported to avoid surprises, or at least check that
> we aren't exporting anything accidentally.  
> nm src/libsepol.so.1 | grep ' T ' shows some interfaces that shouldn't
> really be public at present.
>   
Which ones? I tend to not prefix local things with sepol...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
