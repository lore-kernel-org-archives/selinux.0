Message-ID: <52726B7F.7080707@tycho.nsa.gov>
Date: Thu, 31 Oct 2013 10:38:55 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dan Walsh <dwalsh@redhat.com>
CC: eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 01/10] Add back attributes flag to fix exception crash.
References: <1383228096-4255-1-git-send-email-dwalsh@redhat.com> <1383228096-4255-2-git-send-email-dwalsh@redhat.com>
In-Reply-To: <1383228096-4255-2-git-send-email-dwalsh@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/31/2013 10:01 AM, Dan Walsh wrote:
> ---
>  sepolgen/src/sepolgen/interfaces.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sepolgen/src/sepolgen/interfaces.py b/sepolgen/src/sepolgen/interfaces.py
> index 3258684..88a6dc3 100644
> --- a/sepolgen/src/sepolgen/interfaces.py
> +++ b/sepolgen/src/sepolgen/interfaces.py
> @@ -276,7 +276,7 @@ class InterfaceVector:
>          if attributes:
>              for typeattribute in interface.typeattributes():
>                  for attr in typeattribute.attributes:
> -                    if not attributes.has_key(attr):
> +                    if not attributes.attributes.has_key(attr):
>                          # print "missing attribute " + attr
>                          continue
>                      attr_vec = attributes.attributes[attr]

I pushed this as sepolgen-1.2.1.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
