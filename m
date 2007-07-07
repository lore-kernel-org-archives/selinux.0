Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l67I2IAJ011710
	for <selinux@tycho.nsa.gov>; Sat, 7 Jul 2007 14:02:19 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l67I2IIU000440
	for <selinux@tycho.nsa.gov>; Sat, 7 Jul 2007 18:02:18 GMT
In-Reply-To: <468E7356.5080207@redhat.com>
References: <468E7356.5080207@redhat.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DF3A1347-A2F4-4615-BA13-FDB0904BACAF@nall.com>
Cc: joe.rocklin@ngc.com, Daniel J Walsh <dwalsh@redhat.com>
From: Joe Nall <joe@nall.com>
Subject: Re: [Fwd: libsemanage API]
Date: Sat, 7 Jul 2007 13:01:57 -0500
To: SE Linux <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

extern "C" {
         #include <semanage/semanage.h>
         #include <semanage/user_record.h>
}
#include <iostream>

using namespace std;

int main (int argc, char **argv) {
         semanage_handle_t *sh = semanage_handle_create();

         semanage_user_t **list;
         unsigned int count;

         semanage_connect(sh);

         semanage_user_list(sh, &list, &count);

         for (int i = 0; i < count; i++) {
                 cout << i << ": " << semanage_user_get_name(list[i])  
<< endl;
         }

         return 0;
}

sudo ./a.out
Password:
0: root
1: staff_u
2: sysadm_u
3: system_u
4: user_u

On Jul 6, 2007, at 11:52 AM, Daniel J Walsh wrote:

> extern "C" {
> 	#include <semanage/semanage.h>
> }
> #include <iostream>
>
> using namespace std;
>
> int main (int argc, char **argv) {
> 	semanage_handle_t *sh = semanage_handle_create();
>
> 	semanage_user_t **list;
> 	unsigned int count;
>
> 	semanage_connect(sh);
>
> 	semanage_user_list(sh, &list, &count);
>
> 	for (int i = 0; i < count; i++) {
> 		cout << i << ": " << list[i].name << endl;
> 	}
>
> 	return 0;
> }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
