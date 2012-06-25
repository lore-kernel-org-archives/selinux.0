Message-ID: <1340626529.22057.32.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: samsung galaxy nexus
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexandra Test <testalexandrainstitute@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Mon, 25 Jun 2012 08:15:29 -0400
In-Reply-To: <CAKi3PurN13FgosvoP600NuegoLOPLqc7ueyd8XaEg4-Z0WQvnw@mail.gmail.com>
References: 
	<CAKi3PurN13FgosvoP600NuegoLOPLqc7ueyd8XaEg4-Z0WQvnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-06-25 at 13:18 +0200, Alexandra Test wrote:
> Hi all,
> I succeed (hopefully) in building the version for my samsung galaxy
> nexus. 
> Now I am trying to verify if SEAndroid is also installed. 
> 
> 
> 
> Once you have the emulator or a device running SE Android, you can run
> adb shell and then look for signs that SELinux is present, e.g.
> 
> getenforce
> ls -Z
> ps -Z
> dmesg
> 
> What do I have to check? If I send the command getenforce in the adb shell, nothing happens!
> 
> Can you help me?

adb shell getenforce should display one of: Disabled, Enforcing or
Permissive.

You should also be able to see the SELinux status by looking under About
Phone tab on the Settings app (last entry), or by running the SEManager
app.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
