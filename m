Date: Sun, 09 Jan 2005 14:37:26 +0100 (CET)
From: Bartlomiej Balcerek <Bartlomiej.Balcerek@pwr.wroc.pl>
Subject: Changing context with UID - doubt
To: SELinux@tycho.nsa.gov
Message-id: <Pine.GSO.4.44.0501091400340.4757-100000@sun1000.pwr.wroc.pl>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,
I'am still newbie in SELinux. I'am confused, if SELinux can
automaticaly change process context when changing system EUID ?
My process executes shell with different EUID, which just executes another
subprocess. I want that subprocess to run in role or domain coupled
with its EUID, defined in "user" file. It is possible in SELinux ?

Thanks in advance,
-
Bartlomiej Balcerek
Technical University of Wroclaw
Wroclaw Centre of Networking and Supercomputing
phone: +48 (71) 320-20-43 mail: bartol@pwr.wroc.pl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
