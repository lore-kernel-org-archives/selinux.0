Message-ID: <39e231050509011823c39f6a9@mail.gmail.com>
Date: Thu, 1 Sep 2005 18:23:28 -0700
From: Javier Godinez <godinezj@gmail.com>
Reply-To: godinezj@gmail.com
To: SELinux@tycho.nsa.gov
Subject: Policy devel
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_917_31454281.1125624208730"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_917_31454281.1125624208730
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I am not sure is this is the place to ask policy development noobee=20
questions, but here is my problem.

The process:

/usr/sbin/vmware-serverd

running in vmware_serverd_t spawns the processes:

/usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx
/usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx
/usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx
/usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx

in the vmware_serverd_t, is there a way of making vmware-vmx spawn into=20
another domain, but this other domain must be dependant on the domain of th=
e=20
file that is passed to it (/vms/X/vm.vmx)?

So I need to have vmware-serverd spawn:

/usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx=20
/usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx=20
/usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx=20
/usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx=20

in domain0, and

/usr/lib/vmware/bin/vmware-vmx -C /vms/1/vm.vmx
/usr/lib/vmware/bin/vmware-vmx -C /vms/1/vm.vmx
/usr/lib/vmware/bin/vmware-vmx -C /vms/1/vm.vmx
/usr/lib/vmware/bin/vmware-vmx -C /vms/1/vm.vmx

in domain1.

Any help here will be truly appreciated, Javier Godinez

------=_Part_917_31454281.1125624208730
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I am not sure is this is the place to ask policy development noobee questio=
ns, but here is my problem.<br>
<br>
The process:<br>
<br>
&nbsp; /usr/sbin/vmware-serverd<br>
<br>
running in vmware_serverd_t spawns the processes:<br>
<br>
&nbsp; /usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx<br>
&nbsp; /usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx<br>
&nbsp; /usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx<br>
&nbsp; /usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx<br>
<br>
in the vmware_serverd_t, is there a way of making vmware-vmx spawn into
another domain, but this other domain must be dependant on the domain
of the file that is passed to it (/vms/X/vm.vmx)?<br>
<br>
So I need to have vmware-serverd spawn:<br>
<br>
&nbsp; /usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx <br>
&nbsp; /usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx <br>
&nbsp; /usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx <br>
&nbsp; /usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx <br>
<br>
in domain0, and<br>
<br>
&nbsp; /usr/lib/vmware/bin/vmware-vmx -C /vms/1/vm.vmx<br>
&nbsp; /usr/lib/vmware/bin/vmware-vmx -C /vms/1/vm.vmx<br>
&nbsp; /usr/lib/vmware/bin/vmware-vmx -C /vms/1/vm.vmx<br>
&nbsp; /usr/lib/vmware/bin/vmware-vmx -C /vms/1/vm.vmx<br>
<br>
in domain1.<br>
<br>
Any help here will be truly appreciated, Javier Godinez<br>
<br>
<br>

------=_Part_917_31454281.1125624208730--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
