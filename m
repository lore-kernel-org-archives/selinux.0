Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nASCI7XD030698
	for <selinux@tycho.nsa.gov>; Sat, 28 Nov 2009 07:18:08 -0500
Received: from mail-ew0-f209.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nASCH1Yn029845
	for <selinux@tycho.nsa.gov>; Sat, 28 Nov 2009 12:17:01 GMT
Received: by ewy1 with SMTP id 1so2377539ewy.34
        for <selinux@tycho.nsa.gov>; Sat, 28 Nov 2009 04:18:02 -0800 (PST)
Message-ID: <4B1114E9.7060806@gmail.com>
Date: Sat, 28 Nov 2009 13:17:45 +0100
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: fedora-selinux-list@redhat.com, SE Linux <selinux@tycho.nsa.gov>,
        Kathy Shonaiya <Shonaiya@tresys.com>
Subject: Re: The SELinux Documentation Project
References: <4AC1130D.8000601@manicmethod.com> <4B103712.2050709@manicmethod.com>
In-Reply-To: <4B103712.2050709@manicmethod.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB1975940266EB18B42D42291"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB1975940266EB18B42D42291
Content-Type: multipart/mixed;
 boundary="------------050505030606030503050702"

This is a multi-part message in MIME format.
--------------050505030606030503050702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/27/2009 09:31 PM, Joshua Brindle wrote:
> Joshua Brindle wrote:
>> As we discussed at Linux Plumbers Conference during the 'Making SELinu=
x
>> Easier to Use" talk we have some document deficiencies in the SELinux
>> project.
>>
>=20
> <snip>
>=20
> We have gotten some good contributions to the documentation project ove=
r
> the last couple months but there is always more to do. I've updated the=

> Documentation TODO at:
>=20
> <http://selinuxproject.org/page/Documentation_TODO>
>=20
> with some docs we'd like written and some guidance on what the format
> should be. Use cases would be particularly appreciated.
>=20
> If you haven't gone to the documentation wiki lately take a look at
>=20
> <http://selinuxproject.org/page/Main_Page>
>=20
> and see what's been added.
>=20
> Thanks for the help of the contributors and hopefully this effort will
> go a long way toward gaining users and keeping SELinux enabled.
>=20
> --=20
> fedora-selinux-list mailing list
> fedora-selinux-list@redhat.com
> https://www.redhat.com/mailman/listinfo/fedora-selinux-list

Attached is a concept i wrote today about Locking down webapps with CGI.
This was a topic in the todo list.

Would be nice if someone could proof-read this and when
modified/accepted publish it.

--------------050505030606030503050702
Content-Type: text/plain;
 name="Locking_down_webapps_by_using_CGI.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="Locking_down_webapps_by_using_CGI.txt"

Locking down webapps by using CGI's (or FastCGI), separating CGI's from e=
ach other, user CGI's from system CGI's, etc=20

CGI web applications operate in a seperate process. This enables us to im=
plement SELinux policy for the process. By default two CGI web applicatio=
n domains are provided, additionally SElinux policy API's can be used to =
create new CGI webapplication domains.

The system CGI web application domain is the default CGI web application =
domain for system scripts. This means that if you have configured Apache =
to support CGI and you copy a CGI script into the default system wide loc=
ation for Apache CGI web applications, usually /var/www/cgi-bin, that the=
 script inherits the CGI web application executable type for the parent d=
irectory cgi-bin and that when Apache executes te script that the CGI web=
 application will run in this system cgi script domain. The advantage of =
this domain is that the script does not have to operate with the permissi=
ons of the Apache webserver and that the CGI webapp cannot, to an extend,=
 affect the Apache server or vice versa.

The system cgi webapp domain includes serveral types and booleans that ca=
n be used in different scenarios.

httpd_sys_script_exec_t: The system CGI web application executable file t=
ype.
I mentioned that CGI scripts that are copied to the default system CGI bi=
n inherit the type of the CGI bin directory. The type of this directory i=
s httpd_sys_script_exec_t. When Apache runs a executable with this type i=
t will cause the application that is executed to run in the httpd_sys_scr=
ipt_t domain. To enable this behaviour you must be sure that the httpd_bu=
iltin_scripting, and httpd_enable_cgi booleans are set to on. This can be=
 verified and toggled using the semanage command with the boolean option,=
 followed by the parameters.

httpd_sys_script_t: The system CGI web application domain type.
The httpd_sys_script_t type is the type of a system CGI web application p=
rocess. This type is used to define specific permissions for interactions=
 were the system CGI script is the source of an interaction. Policy where=
 a specific domain type is the source type is also refered to as a domain=
=2E A domain specifies the permissions that a process has.

httpd_sys_content_t: The system web application content file type.
The system web application content file type is a type for files that can=
 be read by the httpd_sys_script_t domain type. When a system CGI web app=
lication wants to read web content, than this content should be labeled w=
ith this type. When you copy web content in the default system web server=
 root, usually /var/www, this content will automatically inherit this typ=
e from the parent directory.

httpd_sys_content_ra_t: The system web application ra content file type.
The system web application ra content file type is a type for files that =
can be read by and appended to by the httpd_sys_script_t domain type. Thi=
s type may be useful when your CGI web application has a log file that is=
 should not be in the main Apache log location, usually /var/log/httpd. T=
his could be useful for virtual hosts where you do not want your customer=
s to be able to access Apache server logs but do want to provide a means =
for system CGI web applications to log, and the logs be accessible by you=
r customers. By default no location is specified for files with this type=
=2E You would manually label a file that you want your CGI web applicatio=
n to read from and append to with for example the chcon and semanage comm=
and.

httpd_sys_content_rw_t: The system web application rw content file type.
The system web application rw content file type is a type for file that c=
an be created and be written to by the httpd_sys_script_t domain type. A =
CGI web application may need to create files or write files. This file ty=
pe provides this functionality. By default no location is specified for f=
iles with this type. You would either manually label a file that you want=
 you CGI web application to write to with for example the chcon and seman=
age command, or you would use te appropriate command to specify a locatio=
n where a CGI web application should be able to create files in.=20

For your CGI web application to be able to write to files with the httpd_=
sys_content_rw_t or create files with the httpd_sys_content_rw_t type you=
 must also make sure that the allow_httpd_sys_script_anon_write is set to=
 on. You can use the set- and getsebool commands to query and toggle bool=
eans. The semanage command with boolean option provides similar functiona=
lity.

httpd_sys_htaccess_t: The system web application htaccess file type.
The systen web application htaccess file type is a type for files that ca=
n only be read by the httpd_t domain type. This type can be used to imple=
ment safe htaccess functionality for a system  CGI web application.

The labeling of the different files and locations can be done with the ch=
con and semanage command used together with the restorecon command. If yo=
u have a system web root in a location that is not standard, than you can=
 use the semanage command with fcontext option to specify what contexts t=
he locations should have. You can base these specifications on the specif=
ications for the /var/www/ locations which can be queried using the seman=
age command with fcontext option and -l parameter. You can also use the e=
quiv option to clone the file context specifications for a location easil=
y. Make sure that you restore the context of the locations after you have=
 specified new contexts. The semanage command expects file contexts to be=
 specified using Bourne shell regular expressions. Keep this in mind when=
 you want to add specification that are complex.

The use of the chcon command is not encouraged however this command can b=
e useful when you do not have permission to use the semanage command.

I mentioned in the first paragraph of this article that there are two CGI=
 web application domains provided. Besides the system CGI web application=
 domain there is also a user CGI web application domain. This domain and =
its types is similar to that of the system CGI application domain. All cl=
asses of types can also be used for this domain only the name slightly di=
ffers (httpd_user_script_t instead of httpd_sys_script_t). This domain is=
 used for the confinement of user CGI web applications for example when t=
he Apache suexec and userdir functionality is enabled.

There are a few minor differences to discus. To enable the Apache userdir=
 functionality you must make sure that the httpd_enable_userdirs boolean =
is set to on. Users do not have access to the semanage command to specify=
 custom locations for web content. Instead the must use the chcon command=
=2E File contexts specified with the chcon command are usually not persis=
tent. When the file system contexts are restored, contexts set using the =
chcon command will be resetted to system wide specification for that loca=
tion. On some distributions httpd user content may be an exception to thi=
s rule when th types are defined to be customizable types. In this case t=
he restorecon command will not try to reset these types.

You may ask yourself, what is all this complexity for? The answer is that=
 it aims to provide integrity. If you have different CGI web applications=
 hosted on your server, you may not want one to application to be able to=
 affect another. This is a form of privilege escalation. A cracked CGI we=
b application might affect other CGI web application hosted on the system=
 or even the web server itself.

With this in mind it may also be a good idea to define additional CGI web=
 application domain types for each system CGI web application you may run=
=2E A SELinux policy API can be used to quickly define a unique set of ty=
pes for a domain that has the same properties as that of the system and u=
ser domain.

Here is an example of how you can create a new set of types to be used fo=
r a CGI webapplication called mywebapp:

echo "policy_module(mywebapp, 1.0.0)" > mywebapp.te;
echo "apache_content_template(mywebapp)" >> mywebapp.te;
make -f /usr/share/selinux/devel/Makefile mywebapp.pp
sudo semodule -i mywebapp.pp

This basically clones the CGI system script domain or CGI user script dom=
ain for our webapp. It creates unique types for us to use like:
httpd_mywebapp_script_exec_t, httpd_mywebapp_script_t, httpd_mywebapp_con=
tent_t, httpd_mywebapp_content_ra_t, httpd_mywebapp_content_rw_t, httpd_m=
ywebapp_htaccess_t.
You can use the semanage command with fcontext option to specify contexts=
 for the location of this particular CGI web application just like we did=
 for the CGI system and user script domain above.

By using unique types for each CGI web application you help prevent privi=
lege escalation and help maintain the integrity of your web applications.=


In conclusion i would like to point you to some useful documentation that=
 may assist you with the configuration of above:

Fedora 11 managing confined services
Fedora 11 SELinux user guide
man setsebool
man getsebool
man semanage
man restorecon
man chcon
man matchpathcon
man httpd_selinux



--------------050505030606030503050702--

--------------enigB1975940266EB18B42D42291
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAksRFPgACgkQMlxVo39jgT/YVwCghu7cJUYoiLpe4geAC1eE/44M
vCsAnj+hwnOkRwgAn8v9x0ndlzMjA/Nq
=QIa1
-----END PGP SIGNATURE-----

--------------enigB1975940266EB18B42D42291--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
