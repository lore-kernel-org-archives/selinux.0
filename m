Date: Wed, 23 Feb 2005 13:48:24 +0100 (CET)
From: Bartlomiej Balcerek <Bartlomiej.Balcerek@pwr.wroc.pl>
Subject: Assigning user context to files out of home dir.
To: SELinux@tycho.nsa.gov
Message-id: <Pine.GSO.4.44.0502231318520.3577-100000@sun1000.pwr.wroc.pl>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,
Recently I've tried to define labeling for files, which are located out of
user home, with user context, such as in user home. I want to label
directories and files according to all user roles.

There is now in "types.fc":

/scratch      -d system_u:object_r:scratch_root_t
/scratch/.+     system_u:object_r:ROLE_scratch_t

Inside scratch are users directories, just like in /home.

Unfortunately i got "invalid context system_u:object_r:ROLE_scratch_t"
from "setfiles".

So, my question is how to properly define such context for files like that
(if possible) ?

thanks in advance,

-
Bartlomiej Balcerek
Technical University of Wroclaw
Wroclaw Centre of Networking and Supercomputing
phone: +48 (71) 320-20-43 mail: bartol@pwr.wroc.pl







--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
