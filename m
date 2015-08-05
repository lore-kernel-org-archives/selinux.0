Subject: Re: [PATCH] sepolgen: Decode output from Popen in Python3
To: Robert Kuska <rkuska@redhat.com>, selinux@tycho.nsa.gov
References: <270866115.3451257.1438758585747.JavaMail.zimbra@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55C261E6.4040008@tycho.nsa.gov>
Date: Wed, 5 Aug 2015 15:20:06 -0400
MIME-Version: 1.0
In-Reply-To: <270866115.3451257.1438758585747.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/05/2015 03:09 AM, Robert Kuska wrote:
> In Python3 output from Popen communicate function
> returns bytes, to handle output as a string it is needed
> to properly decode it.
> 
> Signed-off-by: Robert Kuska <rkuska@redhat.com>

Thanks, applied.

> ---
>  sepolgen/src/sepolgen/audit.py |  7 +++++++
>  sepolgen/src/sepolgen/util.py  | 14 ++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/sepolgen/src/sepolgen/audit.py b/sepolgen/src/sepolgen/audit.py
> index 83efac3..724d3ea 100644
> --- a/sepolgen/src/sepolgen/audit.py
> +++ b/sepolgen/src/sepolgen/audit.py
> @@ -22,6 +22,7 @@ import sys
>  
>  from . import refpolicy
>  from . import access
> +from . import util
>  # Convenience functions
>  
>  def get_audit_boot_msgs():
> @@ -42,6 +43,8 @@ def get_audit_boot_msgs():
>      boottime = time.strftime("%X", s)
>      output = subprocess.Popen(["/sbin/ausearch", "-m", "AVC,USER_AVC,MAC_POLICY_LOAD,DAEMON_START,SELINUX_ERR", "-ts", bootdate, boottime],
>                                stdout=subprocess.PIPE).communicate()[0]
> +    if util.PY3:
> +        output = util.decode_input(output)
>      return output
>  
>  def get_audit_msgs():
> @@ -55,6 +58,8 @@ def get_audit_msgs():
>      import subprocess
>      output = subprocess.Popen(["/sbin/ausearch", "-m", "AVC,USER_AVC,MAC_POLICY_LOAD,DAEMON_START,SELINUX_ERR"],
>                                stdout=subprocess.PIPE).communicate()[0]
> +    if util.PY3:
> +        output = util.decode_input(output)
>      return output
>  
>  def get_dmesg_msgs():
> @@ -66,6 +71,8 @@ def get_dmesg_msgs():
>      import subprocess
>      output = subprocess.Popen(["/bin/dmesg"],
>                                stdout=subprocess.PIPE).communicate()[0]
> +    if util.PY3:
> +        output = util.decode_input(output)
>      return output
>  
>  # Classes representing audit messages
> diff --git a/sepolgen/src/sepolgen/util.py b/sepolgen/src/sepolgen/util.py
> index 4934bec..16e7ca2 100644
> --- a/sepolgen/src/sepolgen/util.py
> +++ b/sepolgen/src/sepolgen/util.py
> @@ -103,6 +103,20 @@ def encode_input(text):
>          encoded_text = text.encode('utf-8')
>      return encoded_text
>  
> +def decode_input(text):
> +    import locale
> +    """Decode given text via preferred system encoding"""
> +    # locale will often find out the correct encoding
> +    encoding = locale.getpreferredencoding()
> +    try:
> +        decoded_text = text.decode(encoding)
> +    except UnicodeError:
> +    # if it fails to find correct encoding then ascii is used
> +    # which may lead to UnicodeError if `text` contains non ascii signs
> +    # utf-8 is our guess to fix the situation
> +        decoded_text = text.decode('utf-8')
> +    return decoded_text
> +
>  class Comparison():
>      """Class used when implementing rich comparison.
>  
> 
